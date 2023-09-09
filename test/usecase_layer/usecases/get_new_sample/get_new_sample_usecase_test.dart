import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/usecase_layer/usecase.dart';

import 'get_new_sample_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
@GenerateNiceMocks([MockSpec<ISampleFactory>()])
void main() {
  // Sample
  final id = SampleId('id');
  const nameValue = 'name';
  final name = SampleName(nameValue);
  final sample = Sample(id: id, name: name);

  // Exception
  final testException = DomainException(message: 'テスト');

  // Mock
  late MockISampleRepository repository;
  late MockISampleFactory factory;

  setUp(() async {
    repository = MockISampleRepository();
    factory = MockISampleFactory();
  });

  test('指定した値のサンプルモデルのDtoを返す', () async {
    when(factory.create(name: nameValue)).thenAnswer((_) async => sample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(sample)).thenAnswer((_) async => {});
    final target =
        GetNewSampleUseCase(factory: factory, repository: repository);
    final actual = await target.executeAsync(name: nameValue);
    verify(repository.save(sample)).called(1);
    expect(
        actual,
        isA<SampleDto>()
            .having((actual) => actual.id, 'id', id.value)
            .having((actual) => actual.name, 'name', name.value));
  });

  test('指定した名前が空の時、UseCaseExceptionを吐く_空の時', () async {
    const expectedMessage = 'UseCaseException: サンプルモデルの名前が空です';
    final target =
        GetNewSampleUseCase(factory: factory, repository: repository);
    expect(
        () => target.executeAsync(name: ''),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.toString(), 'toString', expectedMessage)));
    await Future.delayed(Duration.zero);
    verifyNever(factory.create(name: anyNamed('name')));
    verifyNever(repository.save(any));
  });

  test('サンプルモデルファクトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルの生成に失敗しました', innerException: testException);
    when(factory.create(name: nameValue)).thenThrow(testException);
    final target =
        GetNewSampleUseCase(factory: factory, repository: repository);
    expect(
        () async => await target.executeAsync(name: nameValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(factory.create(name: nameValue)).called(1);
    verifyNever(repository.save(any));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルの生成に失敗しました', innerException: testException);
    when(factory.create(name: nameValue)).thenAnswer((_) async => sample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(sample)).thenThrow(testException);
    final target =
        GetNewSampleUseCase(factory: factory, repository: repository);
    expect(
        () => target.executeAsync(name: nameValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(factory.create(name: nameValue)).called(1);
    verify(repository.save(sample)).called(1);
  });
}

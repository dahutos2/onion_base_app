import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/usecase_layer/usecase.dart';

import 'copy_samples_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
@GenerateNiceMocks([MockSpec<ISampleFactory>()])
void main() {
  // Sample
  final oldId = SampleId('oldId');
  final name = SampleName('name');
  final oldSample = Sample(id: oldId, name: name);

  final newId = SampleId('newId');
  final newSample = Sample(id: newId, name: name);

  // Exception
  final testException = DomainException(message: 'テスト');

  // Mock
  late MockISampleRepository repository;
  late MockISampleFactory factory;

  setUp(() async {
    repository = MockISampleRepository();
    factory = MockISampleFactory();
  });

  test('指定したIdのサンプルモデルをコピーし、新しいサンプルモデルのDtoを返す', () async {
    when(repository.find(oldId)).thenAnswer((_) async => oldSample);
    when(factory.create(name: name.value)).thenAnswer((_) async => newSample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(newSample)).thenAnswer((_) async => {});
    final target = CopySamplesUseCase(repository: repository, factory: factory);
    final actual = await target.executeAsync(sampleIds: <String>[oldId.value]);
    verify(repository.save(newSample)).called(1);
    expect(
        actual,
        isA<List<SampleDto>>()
            .having((actual) => actual.length, 'length', 1)
            .having((actual) => actual.first.id, 'id', newId.value)
            .having((actual) => actual.first.name, 'name', name.value));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする_find',
      () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルのコピーに失敗しました', innerException: testException);
    when(repository.find(oldId)).thenThrow(testException);
    final target = CopySamplesUseCase(repository: repository, factory: factory);
    expect(
        () async => await target.executeAsync(sampleIds: <String>[oldId.value]),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(repository.find(oldId)).called(1);
    verifyNever(factory.create(name: anyNamed('name')));
    verifyNever(repository.save(any));
  });

  test('サンプルモデルレポジトリでサンプルモデルが見つからなかった時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(message: 'サンプルモデルが見つかりませんでした');
    when(repository.find(oldId)).thenAnswer((_) async => null);
    final target = CopySamplesUseCase(repository: repository, factory: factory);
    expect(
        () async => await target.executeAsync(sampleIds: <String>[oldId.value]),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having((e) => e.toString(), 'toString',
                expectedException.toString())));
    await Future.delayed(Duration.zero);
    verify(repository.find(oldId)).called(1);
    verifyNever(factory.create(name: anyNamed('name')));
    verifyNever(repository.save(any));
  });

  test('サンプルモデルファクトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルのコピーに失敗しました', innerException: testException);
    when(repository.find(oldId)).thenAnswer((_) async => oldSample);
    when(factory.create(name: name.value)).thenThrow(testException);
    final target = CopySamplesUseCase(repository: repository, factory: factory);
    expect(
        () async => await target.executeAsync(sampleIds: <String>[oldId.value]),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(repository.find(oldId)).called(1);
    verify(factory.create(name: name.value)).called(1);
    verifyNever(repository.save(any));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする_save',
      () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルのコピーに失敗しました', innerException: testException);
    when(repository.find(oldId)).thenAnswer((_) async => oldSample);
    when(factory.create(name: name.value)).thenAnswer((_) async => newSample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(newSample)).thenThrow(testException);
    final target = CopySamplesUseCase(repository: repository, factory: factory);
    expect(
        () async => await target.executeAsync(sampleIds: <String>[oldId.value]),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(repository.find(oldId)).called(1);
    verify(factory.create(name: name.value)).called(1);
    verify(repository.save(newSample)).called(1);
  });
}

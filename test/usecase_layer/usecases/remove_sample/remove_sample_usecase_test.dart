import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/usecase_layer/usecase.dart';

import 'remove_sample_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
void main() {
  // Sample
  const idValue = 'id';
  final id = SampleId(idValue);
  const nameValue = 'name';
  final name = SampleName(nameValue);
  final sample = Sample(id: id, name: name);

  // Exception
  final testException = DomainException(message: 'テスト');

  // Mock
  late MockISampleRepository repository;

  setUp(() async {
    repository = MockISampleRepository();
  });

  test('指定したIdのサンプルモデルを削除してDtoを返す', () async {
    when(repository.find(id)).thenAnswer((_) async => sample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.remove(sample)).thenAnswer((_) async => {});
    final target = RemoveSampleUseCase(repository: repository);
    final actual = await target.executeAsync(id: idValue);
    verify(repository.find(id)).called(1);
    verify(repository.remove(sample)).called(1);
    expect(
        actual,
        isA<SampleDto>()
            .having((actual) => actual.id, 'id', id.value)
            .having((actual) => actual.name, 'name', name.value));
  });

  test('指定したIdのサンプルモデルが見つからない時、UseCaseExceptionを吐く', () async {
    const expectedMessage = 'UseCaseException: サンプルモデルが見つかりませんでした';
    when(repository.find(id)).thenAnswer((_) async => null);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.remove(sample)).thenAnswer((_) async => {});
    final target = RemoveSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.toString(), 'toString', expectedMessage)));
    await Future.delayed(Duration.zero);
    verify(repository.find(id)).called(1);
    verifyNever(repository.remove(sample));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルの削除に失敗しました', innerException: testException);
    when(repository.find(id)).thenAnswer((_) async => sample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.remove(sample)).thenThrow(testException);
    final target = RemoveSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(repository.find(id)).called(1);
    verify(repository.remove(sample)).called(1);
  });
}

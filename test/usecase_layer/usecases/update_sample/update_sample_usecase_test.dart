import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/usecase_layer/usecase.dart';

import 'update_sample_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
void main() {
  // Sample
  const idValue = 'id';
  final id = SampleId(idValue);
  const oldNameValue = "oldName";
  final oldName = SampleName(oldNameValue);
  final oldSample = Sample(id: id, name: oldName);

  const newNameValue = "newName";
  final newName = SampleName(newNameValue);
  final newSample = Sample(id: id, name: newName);

  // Exception
  final testException = DomainException(message: 'テスト');

  // Mock
  late MockISampleRepository repository;

  setUp(() async {
    repository = MockISampleRepository();
  });

  test('指定したIdのサンプルモデルの名前を変更し、新しいサンプルモデルのDTOを返す', () async {
    when(repository.find(id)).thenAnswer((_) async => oldSample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(newSample)).thenAnswer((_) async => {});
    final target = UpdateSampleUseCase(repository: repository);
    final actual = await target.executeAsync(id: idValue, name: newNameValue);
    verify(repository.find(id)).called(1);
    verify(repository.save(newSample)).called(1);
    expect(
        actual,
        isA<SampleDto>()
            .having((actual) => actual.id, 'id', id.value)
            .having((actual) => actual.name, 'name', newName.value));
  });

  test('指定した名前が空の時、UseCaseExceptionを吐く_nullの時', () async {
    const expectedMessage = 'UseCaseException: サンプルモデルの名前が空です';
    final target = UpdateSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.toString(), 'toString', expectedMessage)));
    await Future.delayed(Duration.zero);
    verifyNever(repository.find(any));
    verifyNever(repository.save(any));
  });

  test('指定した名前が空の時、UseCaseExceptionを吐く_空の時', () async {
    const expectedMessage = 'UseCaseException: サンプルモデルの名前が空です';
    final target = UpdateSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue, name: ''),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.toString(), 'toString', expectedMessage)));
    await Future.delayed(Duration.zero);
    verifyNever(repository.find(any));
    verifyNever(repository.save(any));
  });

  test('指定したIdのサンプルモデルが見つからない時、UseCaseExceptionを吐く', () async {
    const expectedMessage = 'UseCaseException: サンプルモデルが見つかりませんでした';
    when(repository.find(id)).thenAnswer((_) async => null);
    final target = RemoveSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.toString(), 'toString', expectedMessage)));
    await Future.delayed(Duration.zero);
    verify(repository.find(id)).called(1);
    verifyNever(repository.save(any));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final expectedException = UseCaseException(
        message: 'サンプルモデルの更新に失敗しました', innerException: testException);
    when(repository.find(id)).thenAnswer((_) async => oldSample);
    when(repository.transaction<void>(any)).thenAnswer(
        (realInvocation) => realInvocation.positionalArguments.first.call());
    when(repository.save(newSample)).thenThrow(testException);
    final target = UpdateSampleUseCase(repository: repository);
    expect(
        () => target.executeAsync(id: idValue, name: newNameValue),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    await Future.delayed(Duration.zero);
    verify(repository.find(id)).called(1);
    verify(repository.save(newSample)).called(1);
  });
}

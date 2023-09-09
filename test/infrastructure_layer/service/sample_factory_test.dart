import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/infrastructure_layer/service/sample_factory.dart';

import 'sample_factory_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
void main() {
  // Sample
  final id = SampleId('id');
  const nameValue = 'name';
  final name = SampleName(nameValue);
  final sample = Sample(id: id, name: name);

  // Mock
  late MockISampleRepository repository;

  setUp(() async {
    repository = MockISampleRepository();
  });

  test('Idの重複がない時、指定した値のサンプルモデルを生成する', () async {
    when(repository.find(any)).thenAnswer((_) async => null);
    final target = SampleFactory(repository: repository);
    final actual = await target.create(name: nameValue);
    verify(repository.find(any)).called(1);
    expect(
        actual,
        isA<Sample>()
            .having((actual) => actual.id, 'isNotNull', isNotNull)
            .having((actual) => actual.name, 'name', name));
  });

  test('Idの重複が無くなるまで、ループして作成すること', () async {
    final sampleList = [sample, sample, null, sample];
    when(repository.find(any)).thenAnswer((_) async => sampleList.removeAt(0));
    final target = SampleFactory(repository: repository);
    final actual = await target.create(name: nameValue);
    verify(repository.find(any)).called(3);
    expect(
        actual,
        isA<Sample>()
            .having((actual) => actual.id, 'isNotNull', isNotNull)
            .having((actual) => actual.name, 'name', name));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時DomainExceptionをスローする', () async {
    final testException = DomainException(message: 'テスト');
    when(repository.find(any)).thenThrow(testException);
    final target = SampleFactory(repository: repository);
    expect(
        () async => await target.create(name: nameValue),
        throwsA(const TypeMatcher<DomainException>()
            .having((e) => e, 'testException', testException)
            .having((e) => e.message, 'message', testException.message)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
    verify(repository.find(any)).called(1);
  });
}

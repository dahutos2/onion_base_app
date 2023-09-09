import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';
import 'package:base_app/usecase_layer/usecase.dart';

import 'get_all_sample_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
void main() {
  // Sample
  final id = SampleId('id');
  final name = SampleName('name');
  final sample = Sample(id: id, name: name);

  // Mock
  late MockISampleRepository repository;

  setUp(() async {
    repository = MockISampleRepository();
  });

  test('全てサンプルモデルのリストをDtoで返す', () async {
    when(repository.findAll()).thenAnswer((_) async => <Sample>[sample]);
    final target = GetAllSampleUseCase(repository: repository);
    final actual = await target.executeAsync();
    expect(
        actual,
        isA<List<SampleDto>>()
            .having((actual) => actual.length, 'length', 1)
            .having((actual) => actual.first.id, 'id', id.value)
            .having((actual) => actual.first.name, 'name', name.value));
  });

  test('サンプルモデルが発見できない時は、空のDtoのリストを返す', () async {
    when(repository.findAll()).thenAnswer((_) async => <Sample>[]);
    final target = GetAllSampleUseCase(repository: repository);
    final actual = await target.executeAsync();
    verify(repository.findAll()).called(1);
    expect(actual,
        isA<List<SampleDto>>().having((actual) => actual, 'isEmpty', isEmpty));
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時UseCaseExceptionをスローする', () async {
    final testException = DomainException(message: 'テスト');
    final expectedException = UseCaseException(
        message: '全てのサンプルモデルの取得に失敗しました', innerException: testException);
    when(repository.findAll()).thenThrow(testException);
    final target = GetAllSampleUseCase(repository: repository);
    expect(
        () async => await target.executeAsync(),
        throwsA(const TypeMatcher<UseCaseException>()
            .having((e) => e.message, 'message', expectedException.message)
            .having(
                (e) => e.toString(), 'toString', expectedException.toString())
            .having((e) => e.innerException, 'innerException', testException)));
    verify(repository.findAll()).called(1);
  });
}

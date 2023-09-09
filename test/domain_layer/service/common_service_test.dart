import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:base_app/domain_layer/domain.dart';

import 'common_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ISampleRepository>()])
void main() {
  // Sample
  final sampleId = SampleId('sampleId');
  final sampleName = SampleName('sampleName');
  final sample = Sample(id: sampleId, name: sampleName);

  // Exception
  final testException = DomainException(message: 'テスト');

  // Mock
  late MockISampleRepository sampleRepository;

  setUp(() async {
    sampleRepository = MockISampleRepository();
  });

  test('サンプルモデルレポジトリに同じIDが存在しない時Falseを返す', () async {
    when(sampleRepository.find(sampleId)).thenAnswer((_) async => null);
    final target = CommonService(repository: sampleRepository);
    expect(await target.isDuplicated(sampleId), isFalse);
  });

  test('サンプルモデルレポジトリに同じIDが存在する時Trueを返す', () async {
    when(sampleRepository.find(sampleId)).thenAnswer((_) async => sample);
    final target = CommonService(repository: sampleRepository);
    expect(await target.isDuplicated(sampleId), isTrue);
  });

  test('サンプルモデルレポジトリでDomainExceptionを吐いた時DomainExceptionをスローする', () async {
    when(sampleRepository.find(sampleId)).thenThrow(testException);
    final target = CommonService(repository: sampleRepository);
    expect(
        () async => await target.isDuplicated(sampleId),
        throwsA(const TypeMatcher<DomainException>()
            .having((e) => e, 'testException', testException)
            .having((e) => e.message, 'message', testException.message)
            .having(
                (e) => e.toString(), 'toString', testException.toString())));
  });
}

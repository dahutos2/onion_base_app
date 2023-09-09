import 'package:flutter_test/flutter_test.dart';
import 'package:base_app/domain_layer/domain.dart';

void main() {
  const id = '0000-000-00000';

  test('指定したIDのSampleIdが生成できる', () {
    expect(SampleId(id).value, id);
  });

  test('同じIDのSampleIdを同じと判断する', () {
    expect(SampleId(id) == SampleId(id), isTrue);
  });

  test('SampleIdを文字列に変換した値と指定したIDが等しい', () {
    expect(SampleId(id).toString(), id);
  });

  test('cloneしたSampleIdの値が等しい', () {
    final sampleId = SampleId(id);
    expect(sampleId.value, sampleId.clone().value);
  });

  test('SamplesIdが空の時DomainExceptionを吐く', () {
    const expected = 'DomainException: サンプルドメインのIDは空です';
    expect(
        () => SampleId(''),
        throwsA(const TypeMatcher<DomainException>()
            .having((e) => e.toString(), 'toString', expected)));
  });
}

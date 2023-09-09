import 'package:flutter_test/flutter_test.dart';
import 'package:base_app/domain_layer/domain.dart';

void main() {
  const name = 'test';

  test('指定した名前のSampleNameが生成できる', () {
    expect(SampleName(name).value, name);
  });

  test('同じ名前のSampleNameを同じと判断する', () {
    expect(SampleName(name) == SampleName(name), isTrue);
  });

  test('SampleNameを文字列に変換した値と指定した名前が等しい', () {
    expect(SampleName(name).toString(), name);
  });

  test('isEmptyの結果が名前の結果と等しい', () {
    expect(SampleName(name).isEmpty, name.isEmpty);
  });

  test('isNotEmptyの結果が名前の結果と等しい', () {
    expect(SampleName(name).isNotEmpty, name.isNotEmpty);
  });

  test('lengthの結果が名前の結果と等しい', () {
    expect(SampleName(name).length, name.length);
  });

  test('cloneしたSampleNameの値が等しい', () {
    final sampleName = SampleName(name);
    expect(sampleName.value, sampleName.clone().value);
  });

  test('SampleNameが空の時DomainExceptionを吐く', () {
    const expected = 'DomainException: サンプルドメインの名前は空です';
    expect(
        () => SampleName(''),
        throwsA(const TypeMatcher<DomainException>()
            .having((e) => e.toString(), 'toString', expected)));
  });
}

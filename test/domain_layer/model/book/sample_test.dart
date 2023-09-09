import 'package:flutter_test/flutter_test.dart';
import 'package:base_app/domain_layer/model/sample/domain_model_sample.dart';

void main() {
  // sampleの引数1
  final id = SampleId('id');
  final name = SampleName('name');

  // sampleの引数2
  final name2 = SampleName('name2');

  test('指定した値のSampleが生成できる', () {
    final sample = Sample(
      id: id,
      name: name,
    );
    expect(
        sample,
        isA<Sample>()
            .having((sample) => sample.id, 'id', id)
            .having((sample) => sample.name, 'name', name));
  });

  test('Sampleを文字列に変換した値と指定した値が等しい', () {
    final sample = Sample(
      id: id,
      name: name,
    );
    const expected = 'id,\nname';
    expect(sample.toString(), expected);
  });

  test('Sampleの値を変更した際、変更後の値が正しい', () {
    final sample = Sample(
      id: id,
      name: name,
    );
    final changeSample = sample.copyWith(
      name: name2,
    );
    expect(
        changeSample,
        isA<Sample>()
            .having((changeSample) => changeSample == sample, 'changeSample',
                isTrue)
            .having((changeSample) => changeSample.name, 'name', name2));
  });
}

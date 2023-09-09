import 'package:flutter_test/flutter_test.dart';
import 'package:base_app/usecase_layer/dto/usecase_dto.dart';
import 'package:base_app/domain_layer/model/sample/domain_model_sample.dart';

void main() {
  // Sample
  final id = SampleId('id');
  final name = SampleName('name');
  final sample = Sample(id: id, name: name);
  test('指定した値のSampleDtoが生成できる', () {
    final dto = SampleDto(sample);
    expect(
        dto,
        isA<SampleDto>()
            .having((dto) => dto.id, 'id', id.value)
            .having((dto) => dto.name, 'name', name.value));
  });
}

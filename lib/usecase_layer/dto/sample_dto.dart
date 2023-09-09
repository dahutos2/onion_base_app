import 'package:meta/meta.dart';

import '../../domain_layer/model/sample/domain_model_sample.dart';

/// サンプルドメインDTO用クラス
@immutable
class SampleDto {
  final String id;
  final String name;

  SampleDto(Sample source)
      : id = source.id.value,
        name = source.name.value;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is SampleDto && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;
}

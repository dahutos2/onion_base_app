import '../base/domain_model_base.dart';
import 'domain_model_sample.dart';

/// サンプルドメインです
///
/// プロパティ
/// ```dart
/// SampleId id;
/// SampleName name;
/// ```
/// メソッド
/// ```dart
/// String toString()
/// Sample copyWith()
/// ```
class Sample extends BaseObject {
  @override
  // ignore: overridden_fields
  final SampleId id;
  @override
  // ignore: overridden_fields
  final SampleName name;

  const Sample({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  @override
  String toString() => '$id,\n$name';

  @override
  Sample copyWith({
    SampleName? name,
  }) {
    final copiedName = name ?? this.name;

    return Sample(id: id, name: copiedName);
  }
}

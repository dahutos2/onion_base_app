import '../base/domain_model_base.dart';

/// サンプルドメインのID
class SampleId extends BaseId {
  SampleId(String value) : super(value);

  @override
  String get className => 'サンプルドメインのID';

  @override
  BaseId clone() => SampleId(value);
}

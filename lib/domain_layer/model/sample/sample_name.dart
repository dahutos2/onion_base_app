import '../base/domain_model_base.dart';

/// サンプルドメインの名前
class SampleName extends BaseString {
  SampleName(String value) : super(value);

  @override
  String get className => 'サンプルドメインの名前';

  @override
  SampleName clone() => SampleName(value);
}

import '../model/sample/domain_model_sample.dart';

/// サンプルドメイン生成作成用クラス
///
/// 下記をoverride
/// ```dart
/// ・Sample create({required String name});
/// ```
abstract class ISampleFactory {
  Future<Sample> create({required String name});
}

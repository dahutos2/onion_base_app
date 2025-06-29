import '../../model/base/index.dart';

/// レポジトリ作成用クラス
///
/// 下記をoverride
/// ```dart
/// ・Future<T> transaction<T>(Future<T> Function() f);
/// ・Future<BaseObject?> find(BaseId id);
/// ```
abstract class IBaseRepository {
  Future<T?> transaction<T>(Future<T> Function() f);
  Future<BaseObject?> find(BaseId id);
}

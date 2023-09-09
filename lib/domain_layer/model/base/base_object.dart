import 'package:meta/meta.dart';

import 'base_id.dart';
import 'base_string.dart';

/// Object作成用クラス
///
/// 下記をoverride
///```dart
///・BaseObject copyWith();
///```
@immutable
abstract class BaseObject {
  final BaseId id;
  final BaseString name;

  const BaseObject({required this.id, required this.name});
  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BaseObject && other.id == id);

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  @override
  String toString() => '$id,\n$name';

  /// 新しい値のインスタンスを返すメソッド
  BaseObject copyWith();
}

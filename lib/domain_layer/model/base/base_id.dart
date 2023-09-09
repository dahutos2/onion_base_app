import 'package:meta/meta.dart';

import '../../exception/domain_exception.dart';

/// IDを作成する際に使用する抽象クラス
///
/// 下記をoverride
///```dart
/// ・BaseId clone();
/// ```
@immutable
abstract class BaseId {
  final String value;

  BaseId(this.value) {
    if (value.isEmpty) {
      throw DomainException(
          message: '$className${DomainResource.isEmptyError}');
    }
  }
  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BaseId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;

  @override
  String toString() => value;

  /// クラスの名前を返す
  String get className => 'Id';

  /// 新しいインスタンスを返すメソッド
  BaseId clone();
}

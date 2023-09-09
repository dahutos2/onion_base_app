import 'package:meta/meta.dart';

import '../../exception/domain_exception.dart';

/// 文字列を作成する際に使用する抽象クラス
///```dart
/// isEmpty, isNotEmpty, length が使用できる
///```
/// 下記二つをoverrideしてヴァリデーションを追加できる
///```dart
/// ・get className　クラスの名前を設定し、空白チェックを行える
///
/// ・get maxLength　最大文字数を設定し、文字数制限を行える
///```
/// 下記をoverride
///```dart
/// ・BaseString clone();
/// ```
@immutable
abstract class BaseString {
  final String value;
  static const int _intMaxValue = 9223372036854775807;

  BaseString(this.value) {
    if (className.isNotEmpty && value.isEmpty) {
      throw DomainException(
          message: '$className${DomainResource.isEmptyError}');
    }
    if (value.length > maxLength) {
      throw DomainException(
          message: '$className${DomainResource.overLimitError}$maxLength');
    }
  }
  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is BaseString && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  int get length => value.length;

  @override
  String toString() => value;

  /// クラスの名前を返す
  String get className => '';

  /// 最大文字数を返す
  int get maxLength => _intMaxValue;

  /// 新しいインスタンスを返すメソッド
  BaseString clone();
}

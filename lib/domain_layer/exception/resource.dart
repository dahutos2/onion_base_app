/// Domain層のエラー文を管理するクラス
class DomainResource {
  DomainResource._();
  static String get title => 'DomainException: ';
  static String get isEmptyError => 'は空です';
  static String get overLimitError => 'は文字制限を超えています 最大文字数: ';
}

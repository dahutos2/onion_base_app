/// UseCase層のエラー文を管理するクラス
class UseCaseResource {
  UseCaseResource._();
  static String get title => 'UseCaseException: ';
  static String get getNewSampleError => 'サンプルモデルの生成に失敗しました';
  static String get getAllSampleError => '全てのサンプルモデルの取得に失敗しました';
  static String get notFoundSampleError => 'サンプルモデルが見つかりませんでした';
  static String get removeSampleError => 'サンプルモデルの削除に失敗しました';
  static String get updateSampleError => 'サンプルモデルの更新に失敗しました';
  static String get isNullOrEmptySampleNameError => 'サンプルモデルの名前が空です';
  static String get copySampleError => 'サンプルモデルのコピーに失敗しました';
}

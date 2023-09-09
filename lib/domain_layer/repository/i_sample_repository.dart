import '../model/domain_model.dart';
import 'i_base_repository.dart';

/// サンプルドメインレポジトリ作成用クラス
///
/// 下記をoverride
/// ```dart
/// ・Future<T> transaction<T>(Future<T> Function() f);
/// ・Future<Sample?> find(BaseId id);
/// ・Future<List<Sample>> findAll();
/// ・Future<void> save(Sample sample);
/// ・Future<void> remove(Sample sample);
/// ```
abstract class ISampleRepository extends IBaseRepository {
  @override
  Future<Sample?> find(BaseId id);
  Future<List<Sample>> findAll();
  Future<void> save(Sample sample);
  Future<void> remove(Sample sample);
}

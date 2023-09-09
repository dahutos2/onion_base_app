import 'package:meta/meta.dart';

import '../model/base/domain_model_base.dart';
import '../repository/domain_repository.dart';

/// ドメイン共通サービス
/// ```dart
/// Future<bool> isDuplicated(BaseId id)　Idの重複確認が行える
/// ```
@immutable
class CommonService {
  final IBaseRepository _repository;

  const CommonService({required IBaseRepository repository})
      : _repository = repository;

  Future<bool> isDuplicated(BaseId id) async {
    final searched = await _repository.find(id);
    return searched != null;
  }
}

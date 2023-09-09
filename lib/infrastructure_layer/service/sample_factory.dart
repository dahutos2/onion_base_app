import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../domain_layer/model/domain_model.dart';
import '../../domain_layer/repository/domain_repository.dart';
import '../../domain_layer/service/domain_service.dart';

/// サンプルドメイン生成
///
/// ```dart
/// ・Future<Sample> create({required String name})
/// ```
@immutable
class SampleFactory implements ISampleFactory {
  final CommonService _service;

  SampleFactory({
    required ISampleRepository repository,
  }) : _service = CommonService(repository: repository);

  @override
  Future<Sample> create({required String name}) async {
    const uuid = Uuid();
    // IDを生成する
    String newId = uuid.v4();

    // IDに被りがなくなるまで、ループ
    while (await _service.isDuplicated(SampleId(newId))) {
      // 被りがあるので、IDを再生成する
      newId = uuid.v4();
    }
    return Sample(id: SampleId(newId), name: SampleName(name));
  }
}

import 'package:meta/meta.dart';

import '../../../domain_layer/exception/domain_exception.dart';
import '../../../domain_layer/model/domain_model.dart';
import '../../../domain_layer/repository/domain_repository.dart';
import '../../dto/usecase_dto.dart';
import '../../exception/usecase_exception.dart';
import 'i_update_sample_usecase.dart';

@immutable
class UpdateSampleUseCase implements IUpdateSampleUseCase {
  final ISampleRepository _repository;

  const UpdateSampleUseCase({
    required ISampleRepository repository,
  }) : _repository = repository;

  @override
  Future<SampleDto> executeAsync({required String id, String? name}) async {
    if (name == null || name.isEmpty) {
      throw UseCaseException(
          message: UseCaseResource.isNullOrEmptySampleNameError);
    }
    try {
      final oldSample = await _repository.find(SampleId(id));
      if (oldSample == null) {
        throw UseCaseException(message: UseCaseResource.notFoundSampleError);
      }

      Sample newSample = oldSample.copyWith(name: SampleName(name));
      await _repository.transaction<void>(() async {
        await _repository.save(newSample);
      });
      return SampleDto(newSample);
    } on DomainException catch (e) {
      throw UseCaseException(
          message: UseCaseResource.updateSampleError, innerException: e);
    }
  }
}

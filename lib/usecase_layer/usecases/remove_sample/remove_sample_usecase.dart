import 'package:meta/meta.dart';

import '../../../domain_layer/exception/domain_exception.dart';
import '../../../domain_layer/model/domain_model.dart';
import '../../../domain_layer/repository/domain_repository.dart';
import '../../dto/usecase_dto.dart';
import '../../exception/usecase_exception.dart';
import 'i_remove_sample_usecase.dart';

@immutable
class RemoveSampleUseCase implements IRemoveSampleUseCase {
  final ISampleRepository _repository;

  const RemoveSampleUseCase({
    required ISampleRepository repository,
  }) : _repository = repository;

  @override
  Future<SampleDto> executeAsync({required String id}) async {
    try {
      final sample = await _repository.find(SampleId(id));
      if (sample == null) {
        throw UseCaseException(message: UseCaseResource.notFoundSampleError);
      }
      await _repository.transaction<void>(() async {
        await _repository.remove(sample);
      });
      return SampleDto(sample);
    } on DomainException catch (e) {
      throw UseCaseException(
          message: UseCaseResource.removeSampleError, innerException: e);
    }
  }
}

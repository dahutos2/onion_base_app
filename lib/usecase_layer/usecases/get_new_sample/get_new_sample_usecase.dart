import 'package:meta/meta.dart';

import '../../../domain_layer/exception/domain_exception.dart';
import '../../../domain_layer/repository/domain_repository.dart';
import '../../../domain_layer/service/domain_service.dart';
import '../../dto/usecase_dto.dart';
import '../../exception/usecase_exception.dart';
import 'i_get_new_sample_usecase.dart';

@immutable
class GetNewSampleUseCase implements IGetNewSampleUseCase {
  final ISampleFactory _factory;
  final ISampleRepository _repository;

  const GetNewSampleUseCase({
    required ISampleFactory factory,
    required ISampleRepository repository,
  })  : _factory = factory,
        _repository = repository;

  @override
  Future<SampleDto> executeAsync({required String name}) async {
    if (name.isEmpty) {
      throw UseCaseException(
          message: UseCaseResource.isNullOrEmptySampleNameError);
    }
    try {
      final sample = await _factory.create(name: name);
      await _repository.transaction<void>(() async {
        await _repository.save(sample);
      });
      return SampleDto(sample);
    } on DomainException catch (e) {
      throw UseCaseException(
          message: UseCaseResource.getNewSampleError, innerException: e);
    }
  }
}

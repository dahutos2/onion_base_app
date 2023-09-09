import 'package:meta/meta.dart';

import '../../../domain_layer/exception/domain_exception.dart';
import '../../../domain_layer/model/domain_model.dart';
import '../../../domain_layer/repository/domain_repository.dart';
import '../../../domain_layer/service/domain_service.dart';
import '../../dto/usecase_dto.dart';
import '../../exception/usecase_exception.dart';
import 'i_copy_samples_usecase.dart';

@immutable
class CopySamplesUseCase implements ICopySamplesUseCase {
  final ISampleRepository _repository;
  final ISampleFactory _factory;

  const CopySamplesUseCase({
    required ISampleRepository repository,
    required ISampleFactory factory,
  })  : _repository = repository,
        _factory = factory;

  @override
  Future<List<SampleDto>> executeAsync(
      {required List<String> sampleIds}) async {
    try {
      List<SampleDto> list = <SampleDto>[];
      for (final oldId in sampleIds) {
        final oldSample = await _repository.find(SampleId(oldId));
        if (oldSample == null) {
          throw UseCaseException(message: UseCaseResource.notFoundSampleError);
        }
        final newSample = await _factory.create(name: oldSample.name.value);
        await _repository.transaction<void>(() async {
          await _repository.save(newSample);
        });
        list.add(SampleDto(newSample));
      }
      return list;
    } on DomainException catch (e) {
      throw UseCaseException(
          message: UseCaseResource.copySampleError, innerException: e);
    }
  }
}

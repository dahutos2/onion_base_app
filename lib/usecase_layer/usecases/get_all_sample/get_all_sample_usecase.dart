import 'package:meta/meta.dart';

import '../../../domain_layer/exception/domain_exception.dart';
import '../../../domain_layer/repository/domain_repository.dart';
import '../../dto/usecase_dto.dart';
import '../../exception/usecase_exception.dart';
import 'i_get_all_sample_usecase.dart';

@immutable
class GetAllSampleUseCase implements IGetAllSampleUseCase {
  final ISampleRepository _repository;

  const GetAllSampleUseCase({
    required ISampleRepository repository,
  }) : _repository = repository;

  @override
  Future<List<SampleDto>> executeAsync() async {
    try {
      final samples = await _repository.findAll();
      return samples.map((sample) => SampleDto(sample)).toList();
    } on DomainException catch (e) {
      throw UseCaseException(
          message: UseCaseResource.getAllSampleError, innerException: e);
    }
  }
}

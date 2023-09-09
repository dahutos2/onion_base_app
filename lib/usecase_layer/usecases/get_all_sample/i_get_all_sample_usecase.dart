import '../../dto/usecase_dto.dart';

abstract class IGetAllSampleUseCase {
  Future<List<SampleDto>> executeAsync();
}

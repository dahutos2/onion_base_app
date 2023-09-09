import '../../dto/usecase_dto.dart';

abstract class IGetNewSampleUseCase {
  Future<SampleDto> executeAsync({required String name});
}

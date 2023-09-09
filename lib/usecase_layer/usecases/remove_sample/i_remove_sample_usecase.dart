import '../../dto/usecase_dto.dart';

abstract class IRemoveSampleUseCase {
  Future<SampleDto> executeAsync({required String id});
}

import '../../dto/usecase_dto.dart';

abstract class IUpdateSampleUseCase {
  Future<SampleDto> executeAsync({required String id, String? name});
}

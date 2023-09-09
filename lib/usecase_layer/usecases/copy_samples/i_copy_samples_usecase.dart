import '../../dto/usecase_dto.dart';

abstract class ICopySamplesUseCase {
  Future<List<SampleDto>> executeAsync({required List<String> sampleIds});
}

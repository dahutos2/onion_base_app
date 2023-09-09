
import 'package:flutter/material.dart';

import '../../usecase_layer/dto/usecase_dto.dart';
import '../../usecase_layer/usecases/usecase_usecases.dart';

class SampleNotifier with ChangeNotifier {
  final IGetAllSampleUseCase _getAllSampleUseCase;
  final IGetNewSampleUseCase _getNewSampleUseCase;
  final IRemoveSampleUseCase _removeSampleUseCase;
  final IUpdateSampleUseCase _updateSampleUseCase;
  final ICopySamplesUseCase _copySamplesUseCase;

  SampleNotifier({
    required IGetAllSampleUseCase getAllSampleUseCase,
    required GetNewSampleUseCase getNewSampleUseCase,
    required IRemoveSampleUseCase removeSampleUseCase,
    required IUpdateSampleUseCase updateSampleUseCase,
    required ICopySamplesUseCase copySamplesUseCase,
  })  : _getAllSampleUseCase = getAllSampleUseCase,
        _getNewSampleUseCase = getNewSampleUseCase,
        _removeSampleUseCase = removeSampleUseCase,
        _updateSampleUseCase = updateSampleUseCase,
        _copySamplesUseCase = copySamplesUseCase {
    displayList();
  }

  List<SampleDto>? _list;

  List<SampleDto>? get list =>
      _list == null ? null : List.unmodifiable(_list ?? <SampleDto>[]);

  String findName({required String id}) {
    if (_list == null || _list!.isEmpty) {
      return '';
    }
    try {
      final sample = _list!.firstWhere((sample) => sample.id == id);
      return sample.name;
    } catch (_) {
      return '';
    }
  }

  void saveSample({
    required String name,
  }) {
    _getNewSampleUseCase.executeAsync(name: name).then((dto) {
      _list?.add(dto);
      notifyListeners();
    });
  }

  void copySamples({
    required List<String> sampleIds,
  }) {
    _copySamplesUseCase.executeAsync(sampleIds: sampleIds).then((list) {
      _list?.addAll(list);
      notifyListeners();
    });
  }

  void updateSampleName({
    required String id,
    required String name,
  }) {
    _updateSampleUseCase.executeAsync(id: id, name: name).then((dto) {
      if (_list == null) return;
      final index = _list!.indexWhere((sample) => sample.id == dto.id);
      _list![index] = dto;
      notifyListeners();
    });
  }

  void removeSample({
    required String id,
  }) {
    _removeSampleUseCase.executeAsync(id: id).then((dto) {
      _list?.remove(dto);
      notifyListeners();
    });
  }

  void displayList() {
    _getAllSampleUseCase.executeAsync().then((list) {
      _list = list;
      notifyListeners();
    });
  }
}

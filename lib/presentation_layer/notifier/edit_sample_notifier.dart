import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSampleNotifier extends StateNotifier<HashSet<String>> {
  EditSampleNotifier() : super(HashSet<String>());
  void clear() => state = HashSet<String>();

  void change(String sampleId, bool isChecked) {
    if (isChecked) {
      state.add(sampleId);
    } else {
      state.remove(sampleId);
    }
    state = HashSet<String>()..addAll(state);
  }

  void changeAll(List<String> sampleIdList, bool isChecked) {
    if (isChecked) {
      state.addAll(sampleIdList);
    } else {
      state.removeAll(sampleIdList);
    }
    state = HashSet<String>()..addAll(state);
  }
}

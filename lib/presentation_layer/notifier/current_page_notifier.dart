import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrentPage {
  final bool editMode;
  final String? sampleId;
  CurrentPage({required this.editMode, this.sampleId});
}

class CurrentPageNotifier extends StateNotifier<CurrentPage> {
  CurrentPageNotifier() : super(CurrentPage(editMode: false));

  bool get editMode => state.editMode;
  String? get sampleId => state.sampleId;

  void changeState({bool? editMode, String? sampleId}) {
    final changeEditMode = editMode ?? state.editMode;
    final changeSampleId = sampleId ?? state.sampleId;
    state = CurrentPage(editMode: changeEditMode, sampleId: changeSampleId);
  }
}

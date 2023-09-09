import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchSampleNotifier extends StateNotifier<String> {
  SearchSampleNotifier() : super('');
  String get searchText => state;

  void changeText(String searchText) {
    state = searchText;
  }
}

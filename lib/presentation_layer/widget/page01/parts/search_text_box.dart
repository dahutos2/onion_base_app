import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../main.dart';
import '../../../share/presentation_share.dart';

const _gap = 10.0;

class SearchTextBoxView extends ConsumerStatefulWidget {
  const SearchTextBoxView({super.key});

  @override
  SearchTextBoxViewState createState() => SearchTextBoxViewState();
}

class SearchTextBoxViewState extends ConsumerState<SearchTextBoxView> {
  String _inputText = '';
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showCancelButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(searchSampleNotifierProvider);
    _inputText = _searchController.text;
    _searchFocusNode.addListener(() {
      setState(() {
        _showCancelButton = _searchFocusNode.hasFocus;
      });
    });
    _searchController.addListener(() {
      setState(() {
        _inputText = _searchController.text;
        ref.read(searchSampleNotifierProvider.notifier).changeText(_inputText);
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_gap),
      color: ColorType.page01.searchTextBoxBack,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              textInputAction: TextInputAction.search,
              style: StyleType.page01.searchTextBoxInput,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: _gap / 2, vertical: _gap),
                fillColor: ColorType.page01.searchTextBoxFilled,
                filled: true,
                prefixIcon: IconType.common.search,
                hintText: L10n.of(context)!.searchTextBoxHintText,
                hintStyle: StyleType.page01.searchTextBoxHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_gap),
                ),
                suffixIcon: _inputText.isNotEmpty
                    ? IconButton(
                        onPressed: _searchController.clear,
                        icon: IconType.common.textBoxClear,
                      )
                    : null,
              ),
            ),
          ),
          if (_showCancelButton) const SizedBox(width: _gap),
          if (_showCancelButton)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _searchFocusNode.unfocus();
              },
              child: Text(
                L10n.of(context)!.searchTextBoxCancel,
                style: StyleType.page01.searchTextBoxCancel,
              ),
            ),
        ],
      ),
    );
  }
}

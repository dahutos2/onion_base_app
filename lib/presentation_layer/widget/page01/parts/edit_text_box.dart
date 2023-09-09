import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../share/presentation_share.dart';

const _gap = 10.0;

class EditTextBoxView extends ConsumerStatefulWidget {
  final String initText;
  final Function(String name) onChange;
  final String hintText;
  const EditTextBoxView(
      {super.key,
      required this.initText,
      required this.onChange,
      required this.hintText});

  @override
  EditTextBoxViewState createState() => EditTextBoxViewState();
}

class EditTextBoxViewState extends ConsumerState<EditTextBoxView> {
  String _inputText = '';
  bool isFocus = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initText;
    _textController.addListener(() {
      setState(() {
        _inputText = _textController.text;
      });
    });
    _textFocusNode.addListener(() {
      setState(() {
        isFocus = _textFocusNode.hasFocus;
      });
      // フォーカス時は何もしない
      if (_textFocusNode.hasFocus) return;

      if (_inputText.isEmpty) {
        // 空の時にロストフォーカスした際は、初期値に戻す
        _textController.text = widget.initText;
        return;
      }

      // 初期化時と同じ時は何もしない
      if (_inputText == widget.initText) return;

      widget.onChange(_inputText);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      focusNode: _textFocusNode,
      keyboardType: TextInputType.text,
      style: StyleType.page01.editTextBoxInput,
      decoration: InputDecoration(
        fillColor: ColorType.page01.editTextBoxFilled,
        filled: true,
        hintText: widget.hintText,
        hintStyle: StyleType.page01.editTextBoxHintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_gap),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: _gap / 2, vertical: _gap),
        suffixIcon: _inputText.isNotEmpty && isFocus
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _textController.clear();
                  });
                },
                icon: IconType.common.textBoxClear,
              )
            : null,
      ),
    );
  }
}

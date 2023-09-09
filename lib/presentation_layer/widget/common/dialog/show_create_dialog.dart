import 'package:flutter/material.dart';

import '../../../share/presentation_share.dart';

const _gap = 10.0;

Future<T?> showCreateDialog<T>({
  required BuildContext context,
  bool barrierDismissible = false,
  bool useRootNavigator = true,
  required String title,
  required String hintText,
  required String done,
  required Function(String name) onCreate,
}) {
  return showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) => CreateDialog(
          title: title, hintText: hintText, done: done, onCreate: onCreate));
}

class CreateDialog extends StatefulWidget {
  final String title;
  final String hintText;
  final String done;
  final Function(String name) onCreate;
  const CreateDialog({
    super.key,
    required this.title,
    required this.hintText,
    required this.done,
    required this.onCreate,
  });

  @override
  CreateDialogState createState() => CreateDialogState();
}

class CreateDialogState extends State<CreateDialog> {
  String _inputText = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _inputText = _textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submit() {
    String inputText = _textEditingController.text;
    widget.onCreate(inputText);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_gap)),
      ),
      backgroundColor: ColorType.common.createDialogBack,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(_gap * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: StyleType.common.createDialogTitle,
                ),
                const SizedBox(height: _gap * 2),
                Container(
                  padding: const EdgeInsets.all(_gap * 2),
                  decoration: BoxDecoration(
                    color: ColorType.common.createDialogFrontBack,
                    borderRadius: BorderRadius.circular(_gap),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _textEditingController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        style: StyleType.common.createDialogInput,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: _gap / 2, vertical: _gap),
                          fillColor: ColorType.common.createDialogBack,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(_gap),
                          ),
                          hintText: widget.hintText,
                          hintStyle: StyleType.common.createDialogHintText,
                          suffixIcon: _inputText.isEmpty
                              ? null
                              : IconButton(
                                  icon: IconType.common.textBoxClear,
                                  onPressed: () {
                                    setState(() {
                                      _textEditingController.clear();
                                    });
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(height: _gap * 2),
                      SizedBox(
                        width: double.infinity,
                        height: _gap * 4.5,
                        child: ElevatedButton(
                          onPressed: _inputText.isEmpty ? null : _submit,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return ColorType
                                      .common.createDialogDoneDisable;
                                }
                                return ColorType.common.createDialogDone;
                              },
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(_gap),
                              ),
                            ),
                          ),
                          child: Text(
                            widget.done,
                            style: _inputText.isEmpty
                                ? StyleType.common.createDialogDoneDisable
                                : StyleType.common.createDialogDone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              style: IconButton.styleFrom(elevation: 0.0),
              icon: IconType.common.contentDialogClose,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

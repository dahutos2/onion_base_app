import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../extensions/context_extension.dart';
import '../../../share/presentation_share.dart';

const _gap = 10.0;

Future<T?> showAlertDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  required String title,
  required String subTitle,
  required String done,
  String? cancel,
  required Function() onChange,
}) {
  return showDialog<T?>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) => GestureDetector(
      onTap: context.hideKeyboard,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_gap)),
        ),
        backgroundColor: ColorType.common.alertDialogBack,
        title: Center(
          child: _textWithBrackets(title, StyleType.common.alertDialogTitle),
        ),
        titlePadding: const EdgeInsets.only(
            top: _gap * 2, left: _gap * 2, right: _gap * 2),
        content: Text(
          subTitle,
          style: StyleType.common.alertDialogSubTitle,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(
            top: _gap / 2, bottom: _gap * 2, right: _gap * 3, left: _gap * 3),
        actions: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: ColorType.common.alertDialogBorder,
                        width: _gap / 15,
                      ),
                      right: BorderSide(
                        color: ColorType.common.alertDialogBorder,
                        width: _gap / 15,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: onChange,
                    child: Text(
                      done,
                      style: StyleType.common.alertDialogDone,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: ColorType.common.alertDialogBorder,
                        width: _gap / 15,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      cancel ?? L10n.of(context)!.alertDialogCancel,
                      style: StyleType.common.alertDialogCancel,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.zero,
      ),
    ),
  );
}

Widget _textWithBrackets(String text, TextStyle style) {
  // 「」の間のテキストを取得
  int startBracketIndex = text.indexOf('「');
  int endBracketIndex = text.indexOf('」');

  if (startBracketIndex != -1 && endBracketIndex != -1) {
    String part1 = text.substring(0, endBracketIndex + 1);
    String part2 = text.substring(endBracketIndex + 1);

    return Column(
      children: [
        Text(
          part1,
          style: style,
          overflow: TextOverflow.ellipsis,
        ),
        Text(part2, style: style),
      ],
    );
  } else {
    return Text(text, style: style);
  }
}

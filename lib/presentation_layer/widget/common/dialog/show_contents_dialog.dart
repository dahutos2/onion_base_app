import 'package:flutter/material.dart';

import '../../../extensions/context_extension.dart';
import '../../../share/presentation_share.dart';

Future<T?> showContentDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  bool useRootNavigator = true,
  Color? backgroundColor,
  required Widget contentWidget,
}) {
  return showDialog<T?>(
    context: context,
    barrierDismissible: barrierDismissible,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) => GestureDetector(
      onTap: context.hideKeyboard,
      child: AlertDialog(
        backgroundColor: backgroundColor,
        contentPadding: EdgeInsets.zero,
        content: Stack(
          children: [
            SingleChildScrollView(
              child: Center(child: contentWidget),
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
      ),
    ),
  );
}

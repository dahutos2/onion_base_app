import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/dialog/presentation_widget_common_dialog.dart';

Future<void> showDeleteDialog({
  required String title,
  required BuildContext context,
  required Function() onChange,
}) {
  return showAlertDialog<void>(
    context: context,
    title: title,
    subTitle: L10n.of(context)!.alertDialogRemoveSubTitle,
    done: L10n.of(context)!.alertDialogRemoveDone,
    onChange: () {
      onChange();
      Navigator.pop(context);
    },
  );
}

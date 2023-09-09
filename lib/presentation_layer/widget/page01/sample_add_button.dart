import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';
import '../../share/presentation_share.dart';
import '../common/dialog/presentation_widget_common_dialog.dart';

class SampleAddButtonView extends ConsumerWidget {
  const SampleAddButtonView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      backgroundColor: ColorType.page01.addSampleButton,
      child: IconType.page01.addSample,
      onPressed: () async => await showCreateDialog(
        context: context,
        title: L10n.of(context)!.sampleAddButtonDialogTitle,
        hintText: L10n.of(context)!.sampleAddButtonDialogHintText,
        done: L10n.of(context)!.sampleAddButtonDialogDone,
        onCreate: (name) =>
            ref.read(sampleNotifierProvider).saveSample(name: name),
      ),
    );
  }
}

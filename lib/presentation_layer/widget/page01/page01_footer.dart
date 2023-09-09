import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';
import '../../share/presentation_share.dart';
import '../common/presentation_widget_common.dart';
import 'dialog/presentation_widget_page01_dialog.dart';

const _gap = 10.0;

class Page01FooterView extends ConsumerWidget {
  const Page01FooterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentPageNotifierProvider);
    final editSet = ref.watch(editSampleNotifierProvider);
    final actions = [
      () => ref
          .read(sampleNotifierProvider)
          .copySamples(sampleIds: editSet.toList()),
      () async {
        final last = ref
            .read(sampleNotifierProvider.notifier)
            .findName(id: editSet.last);
        await showDeleteDialog(
          title: editSet.length > 1
              ? L10n.of(context)!
                  .alertDialogMultiRemoveTitle(last, editSet.length)
              : L10n.of(context)!.alertDialogRemoveTitle(last),
          context: context,
          onChange: () {
            editSet.toList().forEach(
                  (id) => ref.read(sampleNotifierProvider).removeSample(id: id),
                );
            ref.read(editSampleNotifierProvider.notifier).clear();
          },
        );
      },
      () async {
        await showContentDialog(
          context: context,
          contentWidget: const Text("Tempが押されました。"),
        );
      }
    ];
    return !current.editMode
        ? const FooterView()
        : BottomAppBar(
            color: ColorType.footer.background,
            child: Row(
              children: [
                _buildBottomNavItem(actions[0], IconType.footer.copy,
                    L10n.of(context)!.copyActionFooterLabel, editSet),
                _buildBottomNavItem(actions[1], IconType.footer.delete,
                    L10n.of(context)!.deleteActionFooterLabel, editSet),
                _buildBottomNavItem(actions[2], IconType.footer.temp,
                    L10n.of(context)!.tempActionFooterLabel, editSet),
              ],
            ),
          );
  }

  Widget _buildBottomNavItem(
      Function action, Icon icon, String label, HashSet<String> editSet) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: _gap),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: editSet.isEmpty ? null : () => action.call(),
          icon: Column(
            children: [
              Icon(icon.icon,
                  color: editSet.isEmpty
                      ? ColorType.footer.disabledItem
                      : ColorType.footer.item),
              Expanded(
                child: Text(label,
                    style: editSet.isEmpty
                        ? StyleType.footer.disabledLabel
                        : StyleType.footer.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

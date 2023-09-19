import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../main.dart';
import '../../../usecase_layer/dto/usecase_dto.dart';
import '../../share/presentation_share.dart';

const _gap = 10.0;

class Page01HeaderView extends ConsumerWidget implements PreferredSizeWidget {
  const Page01HeaderView({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void changeCheckedAll(WidgetRef ref, bool isChecked, List<SampleDto>? list) {
    if (list == null) return;
    final sampleIdList = list.map((sample) => sample.id).toList();
    ref
        .read(editSampleNotifierProvider.notifier)
        .changeAll(sampleIdList, isChecked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentPageNotifierProvider);
    final list = ref.read(sampleNotifierProvider).list;
    final searchText = ref.watch(searchSampleNotifierProvider).toLowerCase();
    final checkedSet = ref.watch(editSampleNotifierProvider);
    List<SampleDto>? filteredList;
    if (list != null) {
      filteredList = list
          .where((sample) => sample.name.toLowerCase().contains(searchText))
          .toList();
    }
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        L10n.of(context)!.page01HeaderTitle,
        style: StyleType.header.title,
      ),
      centerTitle: true,
      leadingWidth: _gap * 10,
      leading: !current.editMode
          ? null
          : filteredList != null &&
                  // 全ての要素が選択済みの時
                  filteredList.every((sample) => checkedSet.contains(sample.id))
              ? Padding(
                  padding: const EdgeInsets.only(left: _gap / 2),
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () => changeCheckedAll(ref, false, filteredList),
                    icon: Text(
                      L10n.of(context)!.page01EditAllNotSelect,
                      style: StyleType.header.editComplete,
                      softWrap: false,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: _gap / 2),
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () => changeCheckedAll(ref, true, filteredList),
                    icon: Text(
                      L10n.of(context)!.page01EditAllSelect,
                      style: StyleType.header.editComplete,
                      softWrap: false,
                    ),
                  ),
                ),
      actions: <Widget>[
        !current.editMode
            ? Padding(
                padding: const EdgeInsets.only(right: _gap / 2),
                child: IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: () => ref
                      .read(currentPageNotifierProvider.notifier)
                      .changeState(editMode: true),
                  icon: IconType.header.page01HeaderEdit,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: _gap / 2),
                child: IconButton(
                  alignment: Alignment.centerRight,
                  onPressed: () => {
                    FocusScope.of(context).unfocus(),
                    ref.watch(editSampleNotifierProvider.notifier).clear(),
                    ref
                        .read(currentPageNotifierProvider.notifier)
                        .changeState(editMode: false),
                  },
                  icon: Text(
                    L10n.of(context)!.page01EditComplete,
                    style: StyleType.header.editComplete,
                  ),
                ),
              ),
      ],
      backgroundColor: ColorType.header.background,
    );
  }
}

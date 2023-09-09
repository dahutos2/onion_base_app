import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../main.dart';
import '../../share/presentation_share.dart';
import 'parts/presentation_widget_page01_parts.dart';
import 'presentation_widget_page01.dart';

const _gap = 10.0;

class SampleListView extends ConsumerWidget {
  const SampleListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SearchTextBoxView(),
        Expanded(
          child: _sampleList(context, ref),
        )
      ],
    );
  }

  Widget _sampleList(BuildContext context, WidgetRef ref) {
    final list = ref.watch(sampleNotifierProvider).list;
    final current = ref.watch(currentPageNotifierProvider);
    if (list == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final searchText = ref.watch(searchSampleNotifierProvider).toLowerCase();
    final filteredList = list
        .where((sample) => sample.name.toLowerCase().contains(searchText))
        .toList();
    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          L10n.of(context)!.page01SampleListEmpty,
          style: StyleType.page01.listSampleEmptyMessage,
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async =>
            ref.read(sampleNotifierProvider.notifier).displayList(),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: _gap),
          itemCount: filteredList.length,
          itemBuilder: (context, index) => !current.editMode
              ? SampleContentsView(sample: filteredList[index])
              : SampleEditContentsView(sample: filteredList[index]),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';
import '../../../../usecase_layer/dto/usecase_dto.dart';
import '../../../share/presentation_share.dart';
import 'presentation_widget_page01_parts.dart';

const _gap = 10.0;
const _rate = 1.5;

class SampleEditContentsView extends ConsumerWidget {
  const SampleEditContentsView({super.key, required this.sample});
  final SampleDto sample;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCheckedSet = ref.watch(editSampleNotifierProvider);
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: _gap, right: _gap, left: _gap),
        decoration: BoxDecoration(
          color: ColorType.page01.editSampleBack,
          borderRadius: BorderRadius.circular(_gap),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: _gap, bottom: _gap, right: _gap),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Transform.scale(
                            scale: _rate,
                            child: Checkbox(
                              side: BorderSide(
                                color: ColorType.page01.editSampleCheckBorder,
                                width: _gap / 8,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(_gap),
                                ),
                              ),
                              value: isCheckedSet.contains(sample.id),
                              onChanged: (value) {
                                ref
                                    .read(editSampleNotifierProvider.notifier)
                                    .change(sample.id, value ?? false);
                              },
                            ),
                          ),
                        ),
                        IconType.page01.listSample,
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: _gap),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EditTextBoxView(
                        // 親Widgetの再ビルドの際は、必ず初期化
                        key: UniqueKey(),
                        initText: sample.name,
                        onChange: (String name) => ref
                            .read(sampleNotifierProvider)
                            .updateSampleName(id: sample.id, name: name),
                        hintText: L10n.of(context)!.editSampleTextBoxHintText),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

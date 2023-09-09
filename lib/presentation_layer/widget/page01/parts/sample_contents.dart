import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../usecase_layer/dto/usecase_dto.dart';
import '../../../page/page01/presentation_page01.dart';
import '../../../share/presentation_share.dart';

const _gap = 10.0;

class SampleContentsView extends ConsumerWidget {
  const SampleContentsView({super.key, required this.sample});
  final SampleDto sample;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: _gap, right: _gap, left: _gap),
      decoration: BoxDecoration(
        color: ColorType.page01.listSampleBack,
        borderRadius: BorderRadius.circular(_gap),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_gap),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: IconType.page01.listSample,
            ),
            const SizedBox(width: _gap),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    enableInteractiveSelection: false,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: sample.name,
                        hintStyle: StyleType.page01.listSampleTitle,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(_gap),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(_gap),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: _gap)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () => Navigator.of(context).push(
                  RouteType.slideInToRight<dynamic>(
                    nextPage: const SampleDetailPage(),
                  ),
                ),
                icon: IconType.page01.moveSampleDetail,
              ),
            )
          ],
        ),
      ),
    );
  }
}

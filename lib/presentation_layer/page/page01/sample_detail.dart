import 'package:flutter/material.dart';

import '../../widget/page01/presentation_widget_page01.dart';
import '../common/presentation_page_common.dart';

class SampleDetailPage extends StatelessWidget {
  const SampleDetailPage({super.key});

  @override
  Widget build(BuildContext context) => const BasePage(
        headerTitle: 'sample_detail_title_temp',
        body: SampleDetailView(),
      );
}

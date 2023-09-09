import 'package:flutter/material.dart';

import '../../widget/page01/presentation_widget_page01.dart';
import '../common/presentation_page_common.dart';

class Page01 extends StatelessWidget {
  const Page01({super.key});

  @override
  Widget build(BuildContext context) => const BasePage(
        appBar: Page01HeaderView(),
        body: SampleListView(),
        floatingActionButton: SampleAddButtonView(),
        bottomNavigationBar: Page01FooterView(),
      );
}

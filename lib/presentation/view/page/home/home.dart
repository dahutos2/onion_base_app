import 'package:flutter/material.dart';

import '../../widget/home/index.dart';
import '../common/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => const BasePage(
        appBar: null,
        body: HomeView(),
        bottomNavigationBar: null,
      );
}

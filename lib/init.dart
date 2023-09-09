import 'package:flutter/material.dart';

import 'presentation_layer/page/presentation_page.dart';
import 'presentation_layer/share/presentation_share.dart';
import 'infrastructure_layer/api/infrastructure_api.dart';

const waitMilliSeconds = 1000;

@immutable
class AppInit {
  final GlobalKey<NavigatorState> navigatorKey;

  AppInit({
    required this.navigatorKey,
    required DbHelper dbHelper,
  }) {
    dbHelper.open().then((_) async {
      await Future.delayed(const Duration(milliseconds: waitMilliSeconds));
      await navigatorKey.currentState?.pushAndRemoveUntil<void>(
        RouteType.whiteOut<dynamic>(nextPage: const Page01()),
        (_) => false,
      );
    });
  }
}

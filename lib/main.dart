import 'dart:collection';
import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'index.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを固定.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // デバッグ時のみ
  if (kDebugMode) {
    runZonedGuarded(() {
      FlutterError.onError = (FlutterErrorDetails details) {
        showErrorDialog(_navigatorKey.currentState?.overlay?.context,
            details.exceptionAsString());
      };

      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    }, (error, stackTrace) {
      showErrorDialog(
          _navigatorKey.currentState?.overlay?.context, error.toString());
    });
  } else {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  }
}

// API
final dbHelperProvider = Provider<DbHelper>(
  (_) => DbHelper(),
);

// Repository
final sampleRepositoryProvider = Provider.autoDispose(
  (ref) => SampleRepository(dbHelper: ref.read(dbHelperProvider)),
);

// Factory
final sampleFactoryProvider = Provider.autoDispose(
  (ref) => SampleFactory(repository: ref.read(sampleRepositoryProvider)),
);

// UseCase
final getAllSampleUseCaseProvider = Provider.autoDispose(
  (ref) => GetAllSampleUseCase(repository: ref.read(sampleRepositoryProvider)),
);
final getNewSampleUseCaseProvider = Provider.autoDispose(
  (ref) => GetNewSampleUseCase(
      factory: ref.read(sampleFactoryProvider),
      repository: ref.read(sampleRepositoryProvider)),
);
final removeSampleUseCaseProvider = Provider.autoDispose(
  (ref) => RemoveSampleUseCase(repository: ref.read(sampleRepositoryProvider)),
);
final updateSampleUseCaseProvider = Provider.autoDispose(
  (ref) => UpdateSampleUseCase(repository: ref.read(sampleRepositoryProvider)),
);
final copySamplesUseCaseProvider = Provider.autoDispose(
  (ref) => CopySamplesUseCase(
    repository: ref.read(sampleRepositoryProvider),
    factory: ref.read(sampleFactoryProvider),
  ),
);

// AppInit
final appInitProvider = Provider.autoDispose(
  (ref) => AppInit(
      navigatorKey: _navigatorKey, dbHelper: ref.read(dbHelperProvider)),
);

// Notifier
final currentPageNotifierProvider =
    StateNotifierProvider<CurrentPageNotifier, CurrentPage>(
  (_) => CurrentPageNotifier(),
);
final searchSampleNotifierProvider =
    StateNotifierProvider<SearchSampleNotifier, String>(
  (_) => SearchSampleNotifier(),
);
final editSampleNotifierProvider =
    StateNotifierProvider<EditSampleNotifier, HashSet<String>>(
  (_) => EditSampleNotifier(),
);
final sampleNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => SampleNotifier(
    getAllSampleUseCase: ref.read(getAllSampleUseCaseProvider),
    getNewSampleUseCase: ref.read(getNewSampleUseCaseProvider),
    removeSampleUseCase: ref.read(removeSampleUseCaseProvider),
    updateSampleUseCase: ref.read(updateSampleUseCaseProvider),
    copySamplesUseCase: ref.read(copySamplesUseCaseProvider),
  ),
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: const Locale("ja"),
      navigatorKey: ref.watch(appInitProvider).navigatorKey,
      onGenerateRoute: (_) => RouteType.fadeIn(nextPage: const InitPage()),
    );
  }
}

// ポップアップが表示中か
bool _isErrorDialogVisible = false;

/// 例外発生時にポップアップを表示する
void showErrorDialog(BuildContext? context, String errorMessage) {
  // アプリが初期化されていない時は、何もしない
  if (context == null) return;
  if (!_isErrorDialogVisible) {
    _isErrorDialogVisible = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(L10n.of(context)!.showErrorDialogTitle),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text(L10n.of(context)!.showErrorDialogOK),
              onPressed: () {
                Navigator.of(context).pop();
                _isErrorDialogVisible = false;
              },
            ),
          ],
        );
      },
    ).then((_) => _isErrorDialogVisible = false);
  }
}

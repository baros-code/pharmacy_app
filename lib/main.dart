import 'dart:async';

import 'package:flutter/material.dart';
import 'app/shared/utils/app_router.dart';
import 'app/shared/utils/service_locator.dart';
import 'app/shared/utils/theme/theme.dart';
import 'core/utils/logger.dart';

void main() {
  runZonedGuarded(
    () async {
      // Initialize the app components.
      await _initializeDependencies();
      // Handle Flutter errors.
      FlutterError.onError = _onFlutterError;
      // Run the app.
      runApp(MainApp());
    },
    // Handle Dart errors.
    _onDartError,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      routerConfig: AppRouter.router,
      title: 'Books App',
    );
  }
}

Future<void> _initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.initialize();
}

void _onFlutterError(FlutterErrorDetails details) {
  FlutterError.presentError(details);
  locator<Logger>().error(
    '${details.exceptionAsString()}\n${details.stack.toString()}',
  );
}

void _onDartError(Object error, StackTrace stackTrace) {
  locator<Logger>().error('${error.toString()}\n${stackTrace.toString()}');
}

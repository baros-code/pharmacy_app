import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/features/auth/presentation/cubit/auth_cubit.dart';
import 'app/shared/utils/app_router.dart';
import 'app/shared/utils/firebase_config.dart';
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
    return MultiBlocProvider(
      providers: _getCubitProviders(),
      child: MaterialApp.router(
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        routerConfig: AppRouter.router,
        title: 'Pharmacy App',
      ),
    );
  }

  List<BlocProvider> _getCubitProviders() {
    return [BlocProvider<AuthCubit>(create: (context) => locator<AuthCubit>())];
  }
}

Future<void> _initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables.
  await dotenv.load();
  ServiceLocator.initialize();
  await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);
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

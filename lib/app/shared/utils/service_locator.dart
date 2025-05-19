import 'package:get_it/get_it.dart';

import '../../../core/network/connectivity_manager.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/popup_manager.dart';
import '../../features/auth/presentation/controllers/login_controller.dart';
import '../../features/pharmacy/presentation/controllers/home_controller.dart';
import '../controllers/splash_controller.dart';

final locator = GetIt.instance;

abstract class ServiceLocator {
  static void initialize() {
    // Register core dependencies
    locator
      ..registerSingleton<Logger>(LoggerImpl())
      ..registerSingleton<ConnectivityManager>(ConnectivityManagerImpl())
      ..registerSingleton<PopupManager>(PopupManagerImpl());

    // Register controllers
    locator
      ..registerFactory(() => SplashController(locator(), locator()))
      ..registerFactory(() => LoginController(locator(), locator()))
      ..registerFactory(() => HomeController(locator(), locator()));
  }
}

import 'package:get_it/get_it.dart';

import '../../../core/network/connectivity_manager.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/popup_manager.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login.dart';
import '../../features/auth/domain/use_cases/sign_up.dart';
import '../../features/auth/presentation/controllers/login_controller.dart';
import '../../features/auth/presentation/controllers/sign_up_controller.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
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

    // Register services
    locator.registerLazySingleton<AuthService>(AuthServiceImpl.new);

    // Register repositories
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()),
    );

    // Register use cases
    locator.registerLazySingleton(() => SignUp(locator(), locator()));
    locator.registerLazySingleton(() => Login(locator(), locator()));

    // Register controllers
    locator
      ..registerFactory(() => SplashController(locator(), locator()))
      ..registerFactory(() => SignUpController(locator(), locator()))
      ..registerFactory(() => LoginController(locator(), locator()))
      ..registerFactory(() => HomeController(locator(), locator()));

    // Register cubits
    locator.registerFactory(() => AuthCubit(locator(), locator()));
  }
}

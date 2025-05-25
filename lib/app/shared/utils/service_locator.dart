import 'package:get_it/get_it.dart';

import '../../../core/network/connectivity_manager.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/popup_manager.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/services/auth_service.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/use_cases/login.dart';
import '../../features/auth/domain/use_cases/login_with_google.dart';
import '../../features/auth/domain/use_cases/sign_up.dart';
import '../../features/auth/presentation/controllers/login_controller.dart';
import '../../features/auth/presentation/controllers/sign_up_controller.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/pharmacy/data/repositories/pharmacy_repository_impl.dart';
import '../../features/pharmacy/data/services/pharmacy_remote_service.dart';
import '../../features/pharmacy/domain/repositories/pharmacy_repository.dart';
import '../../features/pharmacy/domain/use_cases/create_prescription.dart';
import '../../features/pharmacy/domain/use_cases/fetch_medications.dart';
import '../../features/pharmacy/domain/use_cases/fetch_prescriptions.dart';
import '../../features/pharmacy/presentation/controllers/create_prescriptions_controller.dart';
import '../../features/pharmacy/presentation/controllers/home_controller.dart';
import '../../features/pharmacy/presentation/controllers/prescriptions_controller.dart';
import '../../features/pharmacy/presentation/cubit/pharmacy_cubit.dart';
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
    locator.registerLazySingleton<PharmacyRemoteService>(
      PharmacyRemoteServiceImpl.new,
    );

    // Register repositories
    locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()),
    );
    locator.registerLazySingleton<PharmacyRepository>(
      () => PharmacyRepositoryImpl(locator()),
    );

    // Register use cases
    locator
      ..registerLazySingleton(() => SignUp(locator(), locator()))
      ..registerLazySingleton(() => Login(locator(), locator()))
      ..registerLazySingleton(() => LoginWithGoogle(locator(), locator()))
      ..registerLazySingleton(() => FetchMedications(locator(), locator()))
      ..registerLazySingleton(() => CreatePrescription(locator(), locator()))
      ..registerLazySingleton(() => FetchPrescriptions(locator(), locator()));

    // Register controllers
    locator
      ..registerFactory(() => SplashController(locator(), locator()))
      ..registerFactory(() => SignUpController(locator(), locator()))
      ..registerFactory(() => LoginController(locator(), locator()))
      ..registerFactory(() => HomeController(locator(), locator()))
      ..registerFactory(() => PrescriptionsController(locator(), locator()))
      ..registerFactory(
        () => CreatePrescriptionsController(locator(), locator()),
      );

    // Register cubits
    locator.registerFactory(() => AuthCubit(locator(), locator(), locator()));
    locator.registerFactory(
      () => PharmacyCubit(locator(), locator(), locator()),
    );
  }
}

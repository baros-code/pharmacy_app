import 'package:go_router/go_router.dart';

import '../../../core/presentation/controller.dart';
import '../utils/app_router.dart';

class SplashController extends Controller<Object> {
  SplashController(super.logger, super.popupManager);

  @override
  void onStart() {
    super.onStart();
    Future.delayed(const Duration(seconds: 1), () {
      // ignore: use_build_context_synchronously
      context.goNamed(RouteConfig.loginRoute.name);
    });
  }
}

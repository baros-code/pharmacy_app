import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

class LoginController extends Controller<Object> {
  LoginController(super.logger, super.popupManager);

  late AuthCubit _authCubit;

  String? email;
  String? password;

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>()..stream.listen(handleAuthStates);
  }

  void handleAuthStates(AuthState state) {
    if (state is LoginLoading) {
      if (context.mounted) {
        popupManager.showProgress(context);
      }
    }
    if (state is LoginSuccess) {
      if (context.mounted) {
        context.goNamed(RouteConfig.homeRoute.name);
        popupManager.hideProgress(context);
      }
    }
    if (state is LoginFailure) {
      if (context.mounted) {
        popupManager.showToastMessage(context, state.error);
        popupManager.hideProgress(context);
      }
    }
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void login() {
    _authCubit.login(email!, password!);
  }

  void loginWithGoogle() {
    _authCubit.loginWithGoogle();
  }

  void goToSignUp() {
    context.goNamed(RouteConfig.signUpRoute.name);
  }
}

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

class SignUpController extends Controller<Object> {
  SignUpController(super.logger, super.popupManager);

  late final AuthCubit _authCubit;

  String? name;
  String? surname;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>()..stream.listen(handleAuthStates);
  }

  void handleAuthStates(AuthState state) {
    if (state is SignUpLoading) {
      popupManager.showProgress(context);
    }
    if (state is SignUpFailure) {
      popupManager.showToastMessage(context, state.error);
      popupManager.hideProgress(context);
    }
    if (state is SignUpSuccess) {
      popupManager.showToastMessage(
        context,
        'Sign up successful! Redirecting...',
      );
      context.goNamed(RouteConfig.homeRoute.name);
      popupManager.hideProgress(context);
    }
  }

  void setName(String value) {
    name = value;
  }

  void setSurname(String value) {
    surname = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setPassword(String value) {
    password = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  void signUp() {
    _authCubit.signUp(email!, password!);
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

class LoginController extends Controller<Object> {
  LoginController(super.logger, super.popupManager);

  late AuthCubit _authCubit;

  final StreamController<bool> _loginFieldsController = StreamController();
  String? email;
  String? password;

  Stream<bool> get loginButtonStream => _loginFieldsController.stream;

  bool areFieldsValid = false;

  @override
  void onStart() {
    super.onStart();
    _authCubit = context.read<AuthCubit>()..stream.listen(handleAuthStates);
    _loginFieldsController.stream.listen((areValid) {
      areFieldsValid = areValid;
    });
  }

  void handleAuthStates(AuthState state) {
    if (state is LoginLoading) {
      popupManager.showProgress(context);
    }
    if (state is LoginSuccess) {
      context.goNamed(RouteConfig.homeRoute.name);
      popupManager.hideProgress(context);
    }
    if (state is LoginFailure) {
      popupManager.showToastMessage(context, state.error);
      popupManager.hideProgress(context);
    }
  }

  void setEmail(String value) {
    email = value;
    _validateFields();
  }

  void setPassword(String value) {
    password = value;
    _validateFields();
  }

  void login() {
    if (areFieldsValid) {
      _authCubit.login(email!, password!);
    } else {
      popupManager.showToastMessage(
        context,
        'Please fill all fields correctly.',
      );
    }
  }

  void goToSignUp() {
    context.goNamed(RouteConfig.signUpRoute.name);
  }

  // Helpers
  void _validateFields() {
    if (email != null &&
        password != null &&
        (email!.contains('@') &&
            email!.contains('.') &&
            password!.length >= 6)) {
      _loginFieldsController.add(true);
    } else {
      _loginFieldsController.add(false);
    }
  }

  // - Helpers
}

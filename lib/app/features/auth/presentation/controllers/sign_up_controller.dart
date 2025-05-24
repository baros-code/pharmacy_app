import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/presentation/controller.dart';
import '../../../../shared/utils/app_router.dart';
import '../cubit/auth_cubit.dart';

// TODO(Baran): Add email validation and password strength validation.
// TODO(Baran): Add password confirmation validation.

// TODO(Baran): Add email verification & resend email page.

// TODO(Baran): Implement sign out.
class SignUpController extends Controller<Object> {
  SignUpController(super.logger, super.popupManager);

  late final AuthCubit _authCubit;

  String? name;
  String? surname;
  String? email;
  String? password;
  String? confirmPassword;

  final StreamController<bool> _signUpFieldsController = StreamController();

  Stream<bool> get signUpFieldsStream => _signUpFieldsController.stream;

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
    _validateSignUp();
  }

  void setSurname(String value) {
    surname = value;
    _validateSignUp();
  }

  void setEmail(String value) {
    email = value;
    _validateSignUp();
  }

  void setPassword(String value) {
    password = value;
    _validateSignUp();
  }

  void setConfirmPassword(String value) {
    confirmPassword = value;
    _validateSignUp();
  }

  void signUp() {
    _authCubit.signUp(email!, password!);
  }

  // Helpers
  void _validateSignUp() {
    if (name != null &&
        surname != null &&
        email != null &&
        password != null &&
        confirmPassword != null &&
        (password == confirmPassword &&
            email!.contains('@') &&
            email!.contains('.') &&
            password!.length >= 6 &&
            confirmPassword!.length >= 6 &&
            name!.isNotEmpty &&
            surname!.isNotEmpty)) {
      _signUpFieldsController.add(true);
    } else {
      _signUpFieldsController.add(false);
    }
  }

  // - Helpers
}

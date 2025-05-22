import 'package:bloc/bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/login_with_google.dart';
import '../../domain/use_cases/sign_up.dart';

part 'auth_state.dart';

// TODO(Baran): Add logout and forgot password use cases.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._signUp, this._login, this._loginWithGoogle)
    : super(AuthInitial());

  final SignUp _signUp;
  final Login _login;
  final LoginWithGoogle _loginWithGoogle;

  void signUp(String email, String password) async {
    emit(SignUpLoading());
    final result = await _signUp(
      params: AuthParams(email: email, password: password),
    );
    if (result.isSuccessful) {
      emit(SignUpSuccess(result.value!));
      return;
    }
    emit(SignUpFailure(result.error!.message));
  }

  void login(String email, String password) async {
    emit(LoginLoading());
    final result = await _login(
      params: AuthParams(email: email, password: password),
    );
    if (result.isSuccessful) {
      emit(LoginSuccess(result.value!));
      return;
    }
    emit(LoginFailure(result.error!.message));
  }

  void loginWithGoogle() async {
    emit(LoginLoading());
    final result = await _loginWithGoogle();
    if (result.isSuccessful) {
      emit(LoginSuccess(result.value!));
      return;
    }
    emit(LoginFailure(result.error!.message));
  }
}

import 'package:bloc/bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/login_with_google.dart';
import '../../domain/use_cases/logout.dart';
import '../../domain/use_cases/sign_up.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._signUp, this._login, this._logout, this._loginWithGoogle)
    : super(AuthInitial());

  final SignUp _signUp;
  final Login _login;
  final Logout _logout;
  final LoginWithGoogle _loginWithGoogle;

  User? userCache;

  void signUp(String email, String password) async {
    emit(SignUpLoading());
    final result = await _signUp(
      params: AuthParams(email: email, password: password),
    );
    if (result.isSuccessful) {
      userCache = result.value;
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
      userCache = result.value;
      emit(LoginSuccess(result.value!));
      return;
    }
    emit(LoginFailure(result.error!.message));
  }

  void loginWithGoogle() async {
    emit(LoginLoading());
    final result = await _loginWithGoogle();
    if (result.isSuccessful) {
      userCache = result.value;
      emit(LoginSuccess(result.value!));
      return;
    }
    emit(LoginFailure(result.error!.message));
  }

  void logout() async {
    emit(LogoutLoading());
    final result = await _logout();
    if (result.isSuccessful) {
      userCache = null;
      emit(LogoutSuccess());
      return;
    }
    emit(LogoutFailure(result.error!.message));
  }
}

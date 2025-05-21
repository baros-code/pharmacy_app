part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class SignUpSuccess extends AuthState {
  const SignUpSuccess(this.user);

  final User user;
}

class SignUpLoading extends AuthState {
  const SignUpLoading();
}

class SignUpFailure extends AuthState {
  const SignUpFailure(this.error);

  final String error;
}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess(this.user);

  final User user;
}

class LoginFailure extends AuthState {
  const LoginFailure(this.error);

  final String error;
}

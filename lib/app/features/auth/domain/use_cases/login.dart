import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login extends UseCase<AuthParams, User, void> {
  Login(this._authRepository, super.logger);

  final AuthRepository _authRepository;

  @override
  Future<Result<User, Failure>> call({AuthParams? params}) {
    return _authRepository.signInWithEmailAndPassword(
      params!.email,
      params.password,
    );
  }
}

class AuthParams {
  const AuthParams({required this.email, required this.password});

  final String email;
  final String password;
}

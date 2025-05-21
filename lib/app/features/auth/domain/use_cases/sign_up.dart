import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import 'login.dart';

class SignUp extends UseCase<AuthParams, User, void> {
  SignUp(this._authRepository, super.logger);

  final AuthRepository _authRepository;

  @override
  Future<Result<User, Failure>> call({AuthParams? params}) {
    return _authRepository.signUpWithEmailAndPassword(
      params!.email,
      params.password,
    );
  }
}

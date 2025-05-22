import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogle extends UseCase<void, User, void> {
  LoginWithGoogle(this._authRepository, super.logger);

  final AuthRepository _authRepository;

  @override
  Future<Result<User, Failure>> call({void params}) {
    return _authRepository.signInWithGoogle();
  }
}

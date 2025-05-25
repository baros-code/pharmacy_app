import '../../../../../core/utils/result.dart';
import '../../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class Logout extends UseCase<void, Object, void> {
  Logout(this._authRepository, super.logger);

  final AuthRepository _authRepository;

  @override
  Future<Result> call({void params}) {
    return _authRepository.signOut();
  }
}

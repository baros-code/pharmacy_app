import '../../../../../core/utils/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<User, Failure>> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Result<User, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Result> signOut();

  Result<User, Failure> getCurrentUser();
}

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/utils/result.dart';
import '../../domain/entities/user.dart' as u;
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authService);

  final AuthService _authService;

  @override
  Future<Result<u.User, Failure>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authService.signUpWithEmailAndPassword(
        email,
        password,
      );
      return result.isSuccessful
          ? Result.success(value: result.value!.toEntity())
          : Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<u.User, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final result = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      return result.isSuccessful
          ? Result.success(value: result.value!.toEntity())
          : Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<u.User, Failure>> signInWithGoogle() async {
    try {
      final result = await _authService.signInWithGoogle();
      return result.isSuccessful
          ? Result.success(value: result.value!.toEntity())
          : Result.failure(result.error);
    } catch (e) {
      if (e is FirebaseAuthException) {}
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result> signOut() async {
    try {
      await _authService.signOut();
      return Result.success();
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Result<u.User, Failure> getCurrentUser() {
    try {
      final result = _authService.getCurrentUser();
      return result.isSuccessful
          ? Result.success(value: result.value!.toEntity())
          : Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}

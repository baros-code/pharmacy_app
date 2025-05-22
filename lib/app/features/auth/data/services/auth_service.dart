// ignore_for_file: require_trailing_commas

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/utils/result.dart';
import '../models/user_model.dart';

abstract class AuthService {
  /// Signs up a user with the given email and password.
  Future<Result<UserModel, Failure>> signUpWithEmailAndPassword(
    String email,
    String password,
  );

  /// Signs in a user with the given email and password.
  Future<Result<UserModel, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Result<UserModel, Failure>> signInWithGoogle();

  /// Signs out the current user.
  Future<void> signOut();

  /// Returns the current user.
  Result<UserModel, Failure> getCurrentUser();
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Result<UserModel, Failure>> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(
        value: UserModel(
          id: userCredential.user?.uid,
          name: userCredential.user?.displayName,
          email: userCredential.user?.email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      final authCode = SignUpExceptionCode.fromCode(e.code);
      return Result.failure(Failure(message: authCode.message));
    }
  }

  @override
  Future<Result<UserModel, Failure>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result.success(
        value: UserModel(
          id: userCredential.user?.uid,
          name: userCredential.user?.displayName,
          email: userCredential.user?.email,
        ),
      );
    } on FirebaseAuthException catch (e) {
      final authCode = LoginExceptionCode.fromCode(e.code);
      return Result.failure(Failure(message: authCode.message));
    }
  }

  @override
  Future<Result<UserModel, Failure>> signInWithGoogle() async {
    UserCredential? userCredential;
    try {
      if (kIsWeb) {
        final authProvider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(
          authProvider,
        );
      } else {
        // Trigger Google Sign-In flow
        final googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          throw Exception('Google sign-in aborted');
        }

        // Obtain the auth details from the request
        final googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
      }
      return Result.success(
        value: UserModel(
          id: userCredential.user?.uid,
          name: userCredential.user?.displayName,
          email: userCredential.user?.email,
        ),
      );
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'sign_in_failed') {
          return Result.failure(
            Failure(
              message: '''Google sign-in failed. Please try again later!''',
            ),
          );
        }
        return Result.failure(Failure(message: e.code));
      } else {
        return Result.failure(Failure(message: 'An unknown error occurred.'));
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Result<UserModel, Failure> getCurrentUser() {
    return firebaseAuth.currentUser != null
        ? Result.success(
          value: UserModel(
            id: firebaseAuth.currentUser!.uid,
            name: firebaseAuth.currentUser!.displayName,
            email: firebaseAuth.currentUser!.email,
          ),
        )
        : Result.failure(Failure(message: 'No user is currently signed in'));
  }
}

enum LoginExceptionCode {
  invalidEmail(['invalid-email'], 'The email address is not valid.'),
  userDisabled(['user-disabled'], 'This user account has been disabled.'),
  userNotFound(['user-not-found'], 'No user found with this email.'),
  wrongPassword([
    'wrong-password',
    'INVALID_LOGIN_CREDENTIALS',
    'invalid-credential',
  ], 'Incorrect password or login credentials.'),
  tooManyRequests(['too-many-requests'], 'Too many requests. Try again later.'),
  userTokenExpired([
    'user-token-expired',
  ], 'Session expired. Please log in again.'),
  networkRequestFailed([
    'network-request-failed',
  ], 'Network error. Check your internet connection.'),
  operationNotAllowed([
    'operation-not-allowed',
  ], 'Email/password sign-in is not enabled.'),
  unknown(['unknown'], 'An unknown error occurred.');

  const LoginExceptionCode(this.codes, this.message);

  final List<String> codes;
  final String message;

  static LoginExceptionCode fromCode(String code) {
    return LoginExceptionCode.values.firstWhere(
      (e) => e.codes.contains(code),
      orElse: () => LoginExceptionCode.unknown,
    );
  }
}

enum SignUpExceptionCode {
  emailAlreadyInUse(
    'email-already-in-use',
    'An account already exists with this email address.',
  ),
  invalidEmail('invalid-email', 'The email address is not valid.'),
  operationNotAllowed(
    'operation-not-allowed',
    'Email/password sign-in is not enabled.',
  ),
  weakPassword('weak-password', 'The password is too weak.'),
  tooManyRequests(
    'too-many-requests',
    'Too many requests. Please try again later.',
  ),
  userTokenExpired(
    'user-token-expired',
    'Session expired. Please log in again.',
  ),
  networkRequestFailed(
    'network-request-failed',
    'Network error. Please check your internet connection.',
  ),
  unknown('unknown', 'An unknown error occurred.');

  const SignUpExceptionCode(this.code, this.message);

  final String code;
  final String message;

  static SignUpExceptionCode fromCode(String code) {
    return SignUpExceptionCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => SignUpExceptionCode.unknown,
    );
  }
}

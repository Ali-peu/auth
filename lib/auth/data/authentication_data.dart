import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationData {
  Future<bool> signWithPhoneNumber() async {
    log('Тут происходит фиктивный процесс регистрации с помощью телефона',
        name: 'AuthenticationData signWithPhoneNumber: ');
    return true;
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (exceptions) {
      log(exceptions.toString(),
          name: "AuthenticationData login FirebaseAuthException errors");
      throw LogInWithEmailAndPasswordFailure.fromCode(exceptions.code);
    } catch (error) {
      log(error.toString(), name: "AuthenticationData login errors");
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } on FirebaseAuthException catch (firebaseAuthException) {
      log(firebaseAuthException.code,
          name: 'AuthenticationData signUp firebaseAuthException');
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          firebaseAuthException.code);
    } catch (error) {
      log(error.toString(), name: 'AuthenticationData signUp error');
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signInWithGoogle() async {
    // TODO Рассмотреть логику
    final _googleSignIn = GoogleSignIn();
    final _auth = FirebaseAuth.instance;

    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final currentUser = _googleSignIn.currentUser;

        await _auth.signInWithCredential(credential);
        final jsonDocument = await FirebaseUserSettings().getUserInfo();
        if (currentUser != null) {
          final name = jsonDocument['fullName'] as String;
          if (name.isEmpty) {
            var myUser = MyUser.empty;

            myUser = MyUser(
                userId: googleSignInAuthentication.idToken.toString(),
                email: currentUser.email,
                phoneNumber: '',
                name: '');

            await FirebaseUserSettings().createUser(myUser);
          } else {}
        }
      }
    } on FirebaseAuthException catch (authException) {
      log(authException.code,
          name: 'AuthenticationData signInWithGoogle FirebaseAuthException');
      throw LogInWithGoogleFailure.fromCode(authException.code);
    } catch (error) {
      log(error.toString(),
          name: 'AuthenticationData signInWithGoogle FirebaseAuthException');
      throw const LogInWithGoogleFailure();
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

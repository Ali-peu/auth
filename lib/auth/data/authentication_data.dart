import 'package:auth/auth/domain/authentication_data_exceptions.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer' as dev;

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationData {
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (exceptions) {
      dev.log(exceptions.toString(),
          name: "AuthenticationData login FirebaseAuthException errors");
      throw LogInWithEmailAndPasswordFailure.fromCode(exceptions.code);
    } catch (error) {
      dev.log(error.toString(), name: "AuthenticationData login errors");
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);

      myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } on FirebaseAuthException catch (firebaseAuthException) {
      dev.log(firebaseAuthException.code,
          name: 'AuthenticationData signUp firebaseAuthException');
      throw SignUpWithEmailAndPasswordFailure.fromCode(
          firebaseAuthException.code);
    } catch (error) {
      dev.log(error.toString(), name: 'AuthenticationData signUp error');
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (authException) {
      dev.log(authException.code,
          name: 'AuthenticationData signInWithGoogle FirebaseAuthException');
      throw LogInWithGoogleFailure.fromCode(authException.code);
    } catch (error) {
      dev.log(error.toString(),
          name: 'AuthenticationData signInWithGoogle FirebaseAuthException');
      throw const LogInWithGoogleFailure();
    }
  }
}

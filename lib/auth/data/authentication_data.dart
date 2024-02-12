import 'package:auth/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationData {
  Future<bool> signWithPhoneNumber() async {
    dev.log('Тут происходит фиктивный процесс регистрации с помощью телефона',
        name: 'AuthenticationData signWithPhoneNumber: ');
    return true;
  }

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'Success';
    } on FirebaseAuthException catch (exceptions) {
      dev.log(exceptions.toString());

      return exceptions.toString();
    }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    MyUser signUpUser = MyUser.empty;
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);

      signUpUser = myUser.copyWith(userId: user.user!.uid);
      dev.log(user.user!.uid, name: 'User uid from FIREBASE');

      return myUser;
    } on FirebaseAuthException catch (firebaseAuthException) {
      signUpUser = signUpUser.copyWith(name: firebaseAuthException.toString());
      return signUpUser;
    } catch (error) {
      signUpUser = signUpUser.copyWith(name: error.toString());
      return signUpUser;
    }
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String result = 'result';

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential);

        result = 'Success';
        return result;
      }
    } catch (e) {
      result = e.toString();
      return result;
    }

    return result;
  }
}

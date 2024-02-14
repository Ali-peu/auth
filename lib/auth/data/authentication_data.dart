import 'package:auth/auth/data/firebase_user_settings.dart';
import 'package:auth/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationData {
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'Success'; // Не используй так строки, однажды опечатаешься и будешь очень долго дебажить. Передавай объект и коды состояния, для примера глянь как сделано в примерах https://github.com/felangel/bloc/blob/master/examples/flutter_firebase_login/packages/authentication_repository/lib/src/authentication_repository.dart
    } on FirebaseAuthException catch (exceptions) {
      dev.log(exceptions.toString());

      return exceptions.toString();
    } // Добавь обычный catch в том числе, на слушай сторонних ошибок. Например сетевых.
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    MyUser signUpUser = MyUser.empty;
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);

      signUpUser = myUser.copyWith(userId: user.user!.uid);

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

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

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'Success';
    } on FirebaseAuthException catch (exceptions) {
      log(exceptions.toString());

      return exceptions.toString();
    }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    MyUser signUpUser = MyUser.empty;
    try {
      log(myUser.email, name: 'AuthenticationData myUser email:');
      log(myUser.userId, name: 'AuthenticationData myUser userId:');
      log(myUser.phoneNumber, name: 'AuthenticationData myUser phoneNumber:');
      log(myUser.name, name: 'AuthenticationData myUser name:');

      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);

      signUpUser = myUser.copyWith(userId: user.user!.uid);
      log(user.user!.uid, name: 'User uid from FIREBASE');

      return signUpUser;
    } on FirebaseAuthException catch (firebaseAuthException) {
      signUpUser = signUpUser.copyWith(name: firebaseAuthException.toString());
      return signUpUser;
    } catch (error) {
      signUpUser = signUpUser.copyWith(name: error.toString());
      return signUpUser;
    }
  }

  Future<String> signInWithGoogle() async {
    // TODO Рассмотреть логику
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

        final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

        await _auth.signInWithCredential(credential);
        Map<String, dynamic> jsonDocument =
            await FirebaseUserSettings().getUserInfo();
        if (currentUser != null) {
          String name = jsonDocument['fullName'];
          if (name.isEmpty) {
            MyUser myUser = MyUser.empty;

            myUser = MyUser(
                userId: googleSignInAuthentication.idToken.toString(),
                email: currentUser.email,
                phoneNumber: '',
                name: '');

            FirebaseUserSettings().createUser(myUser);
            return currentUser.email;
          } else {
            return jsonDocument['email'];
          }
        }
        result = currentUser?.email ?? 'Success'; // TODO
        return result;
      }
    } catch (e) {
      result = e.toString();
      return result;
    }

    return result;
  }
}

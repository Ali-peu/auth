import 'package:auth/auth/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;

class AuthenticationData {
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

      return myUser;
    } on FirebaseAuthException catch (firebaseAuthException) {
      signUpUser = signUpUser.copyWith(name: firebaseAuthException.toString());
      return signUpUser;
    } catch (error) {
      signUpUser = signUpUser.copyWith(name: error.toString());
      return signUpUser;
    }
  }
}

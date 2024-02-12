import 'package:auth/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';

class FirebaseUserSettings {
  final usersCollection = FirebaseFirestore.instance.collection('user');

  Future<String> createUser(MyUser myUser) async {
    try {
      log(myUser.email, name: "FirebaseUserSettings user email: ");
      await usersCollection.doc(myUser.email.trim()).set(myUser.toDocument());
      return "Success";
    } on FirebaseAuthException catch (authException) {
      log(authException.toString());
      return authException.toString();
    }
  }

  Future<void> updateFirebaseUserDocument(String email, String name) async {
    log(email, name: 'FirebaseUser EMAIL:');

    await usersCollection.doc(email).update({'fullName': name});
  }
}

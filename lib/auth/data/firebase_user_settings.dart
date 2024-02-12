import 'package:auth/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer' as dev;

class FirebaseUserSettings {
  final usersCollection = FirebaseFirestore.instance.collection('user');

  Future<String> createUser(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.email).set(myUser.toDocument());
      return "Success";
    } on FirebaseAuthException catch (authException) {
      dev.log(authException.toString());
      return authException.toString();
    }
  }

  Future<void> updateFirebaseUserDocument(String email, String name) async {
    await usersCollection.doc(email).update({'name': 'name'});
  }
}

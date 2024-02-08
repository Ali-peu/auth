import 'package:auth/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer' as dev;

class FirebaseUserSettings {
  final usersCollection = FirebaseFirestore.instance.collection('user');
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.phoneNumber).set(myUser.toDocument());
      return true;
    } on FirebaseAuthException catch (authException) {
      dev.log(authException.toString());
      return false;
    }
  }
}

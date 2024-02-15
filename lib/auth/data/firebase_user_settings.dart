import 'package:auth/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:developer' as dev;

class FirebaseUserSettings {
  final usersCollection = FirebaseFirestore.instance.collection('user');

  Future<void> createUser(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.email).set(myUser.toDocument());
    } on FirebaseException catch (firebaseException) {
      dev.log(firebaseException.toString(),
          name: 'FirebaseUserSettings createUser FirebaseException');
      throw firebaseException.code;
    } catch (error) {
      dev.log(error.toString(), name: 'FirebaseUserSettings createUser error');
      throw error.toString();
    }
  }
}

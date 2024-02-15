import 'package:auth/auth/domain/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer';

class FirebaseUserSettings {
  final usersCollection = FirebaseFirestore.instance.collection('user');

  Future<void> createUser(MyUser myUser) async {
    try {
      log(myUser.email, name: "FirebaseUserSettings user email: ");
      await usersCollection.doc(myUser.email.trim()).set(myUser.toDocument());
    } on FirebaseException catch (firebaseException) {
      log(firebaseException.toString(),
          name: 'FirebaseUserSettings createUser FirebaseException');
      throw firebaseException.code;
    } catch (error) {
      log(error.toString(), name: 'FirebaseUserSettings createUser error');
      throw error.toString();
    }
  }

  Future<void> updateFirebaseUserDocument(String email, String name) async {
    log(email, name: 'FirebaseUser EMAIL:');
    await usersCollection.doc(email).update({'fullName': name});
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await usersCollection.doc(email).get();
      return docSnapshot.data()!;
    } on FirebaseException catch (firebaseException) {
      log(firebaseException.code,
          name: 'FirebaseExceptions on getUserInfo FirebaseUserSettings');
      throw firebaseException.code;
    } catch (error) {
      log(error.toString(),
          name: 'Exceptions on getUserInfo FirebaseUserSettings');
      throw error.toString();
    }
  }
}

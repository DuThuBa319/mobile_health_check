import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@singleton
class FirebaseAuthService {
  late final _firebaseAuth = FirebaseAuth.instance;
  User? get curentUser => _firebaseAuth.currentUser;

  //Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  bool get isSignedIn => _firebaseAuth.currentUser != null;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String id,
      required String role,
      required String name,
      required String phoneNumber}) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    final user = <String, dynamic>{
      "id": id,
      "email": email,
      "phoneNumber": phoneNumber,
      "role": role,
      "name": name
    };

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user?.uid)
        .set(user);
    debugPrint("Signed up with New ID");
  }

  Future<void> signOut() {
    // userDataData.setToken('');
    return _firebaseAuth.signOut();
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    bool success = false;

    //Create an instance of the current user.
    var user = FirebaseAuth.instance.currentUser!;
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = true;
        //user.doc(userCredential.user?.uid).update({"password": newPassword});
      }).catchError((error) {});
    }).catchError((err) {});

    return success;
  }
}

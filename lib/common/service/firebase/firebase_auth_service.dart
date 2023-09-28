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
}

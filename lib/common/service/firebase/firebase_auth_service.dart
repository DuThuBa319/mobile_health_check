import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

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

  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);
  // }

  // Future<bool> checkIfLogin() async {
  //   bool isLogin = false;
  //   _firebaseAuth.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       isLogin = true;
  //     }
  //   });
  //   return isLogin;
  // }

  Future<void> signOut() {
    // userDataData.setToken('');
    return _firebaseAuth.signOut();
  }
}
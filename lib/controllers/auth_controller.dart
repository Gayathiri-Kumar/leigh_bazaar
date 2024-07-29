import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;

      // Save user details in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
}

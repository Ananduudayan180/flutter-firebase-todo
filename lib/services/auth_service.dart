import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_flow/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> registerUser(UserModel user) async {
    UserCredential userData = await _auth.createUserWithEmailAndPassword(
      email: user.email.toString(),
      password: user.password.toString(),
    );

    if (userData.user != null) {
      await _userCollection.doc(userData.user!.uid).set({
        'uid': userData.user!.uid,
        'name': user.name,
        'email': userData.user!.email,
        'createAt': user.createdAt,
        'status': user.status,
      });
    }
  }
}

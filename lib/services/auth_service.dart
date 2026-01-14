import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_flow/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('users');

  Future<UserCredential> registerUser(UserModel user) async {
    final UserCredential userData;
    try {
      userData = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      if (userData.user != null) {
        await _userCollection.doc(userData.user!.uid).set({
          'uid': userData.user!.uid,
          'name': user.name,
          'email': userData.user!.email,
          'status': user.status,
          'createAt': user.createdAt,
        });
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      rethrow;
    }
    return userData;
  }
}

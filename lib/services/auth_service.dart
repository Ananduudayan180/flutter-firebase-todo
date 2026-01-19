import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> loginUser(UserModel user) async {
    final UserCredential userData;
    try {
      userData = await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      if (userData.user == null) {
        throw Exception('User is null after login');
      }
      SharedPreferences pref = await SharedPreferences.getInstance();
      final String? token = await userData.user!.getIdToken();
      if (token == null) {
        throw Exception('Token is null');
      }
      DocumentSnapshot snap = await _userCollection
          .doc(userData.user!.uid)
          .get();
      await pref.setString('token', token);
      await pref.setString('name', snap['name']);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (_) {
      rethrow;
    } on FirebaseException catch (_) {
      rethrow;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

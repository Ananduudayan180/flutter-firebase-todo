import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? password;
  final String? name;
  final DateTime? createdAt;
  final int? status;
  final String? uid;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.createdAt,
    this.status,
    this.uid,
  });

  factory UserModel.formJson(DocumentSnapshot data) {
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      status: data['status'],
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'status': status,
      'createdAt': createdAt,
    };
  }
}

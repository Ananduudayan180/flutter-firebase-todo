import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String? title;
  final String? content;
  final int? status;
  final DateTime? createAt;

  TaskModel({this.id, this.title, this.content, this.status, this.createAt});

  factory TaskModel.fromJson(DocumentSnapshot snap) {
    return TaskModel(
      id: snap['id'],
      title: snap['title'],
      content: snap['content'],
      status: snap['status'],
      createAt: snap['createAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'status': status,
      'createAt': createAt,
    };
  }
}

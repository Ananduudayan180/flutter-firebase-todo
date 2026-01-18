import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_flow/models/task_model.dart';

class TaskService {
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection('tasks');

  Future<void> addUserTask(TaskModel task) async {
    await _taskCollection.doc(task.id).set(task.toJson());
  }

  Future<void> updateUserTask(TaskModel task) async {
    await _taskCollection.doc(task.id).update(task.toJson());
  }
}

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

  Future<void> deleteUserTask(String id) async {
    await _taskCollection.doc(id).delete();
  }

  Stream<List<TaskModel>> getAllUserTask() {
    try {
      return _taskCollection.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return TaskModel.fromJson(doc);
        }).toList();
      });
    } on FirebaseException catch (_) {
     rethrow;
    }
  }
}

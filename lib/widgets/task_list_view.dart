import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/screens/add_task_page.dart';
import 'package:task_flow/services/task_service.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/widgets/circular_indicator.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TaskService _taskService = TaskService();
  Future<void> deleteTask(TaskModel task) async {
    try {
      await TaskService().deleteUserTask(task.id!);
      if (!mounted) return;
    } on FirebaseException catch (e) {
      ShowExceptionBar.showSnackBar(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TaskModel>>(
      stream: _taskService.getAllUserTask(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularIndicator(isLoading: true);
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some Error Occured'));
        }
        if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(child: Text('Add Your Task'));
        }
        if (snapshot.hasData && //hasdata means data und (has - und)
            snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final task = snapshot.data![index];
              return Card(
                color: widget.themeData.scaffoldBackgroundColor,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.circle_outlined, color: Colors.white),
                  ),
                  title: Text(
                    task.title!,
                    style: widget.themeData.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    task.content!,
                    style: widget.themeData.textTheme.bodyMedium,
                  ),
                  trailing: SizedBox(
                    height: 100,
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.teal,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (cxt) {
                                  return AddTaskPage(taskModel: task);
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () async {
                            await deleteTask(task);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        }
        return CircularIndicator(isLoading: true);
      },
    );
  }
}

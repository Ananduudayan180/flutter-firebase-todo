import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/widgets/circular_indicator.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.themeData});

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularIndicator(isLoading: true);
        }
        if (snapshot.hasError) {
          return Center(child: Text('Some Error Occured'));
        }
        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Add Your Task'));
        }
        if (snapshot.hasData && //hasdata means data und (has - und)
            snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final task = TaskModel.fromJson(snapshot.data!.docs[index]);
              return Card(
                color: themeData.scaffoldBackgroundColor,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.circle_outlined, color: Colors.white),
                  ),
                  title: Text(
                    task.title!,
                    style: themeData.textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    task.content!,
                    style: themeData.textTheme.bodyMedium,
                  ),
                  trailing: SizedBox(
                    height: 100,
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          color: Colors.teal,
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          color: Colors.red,
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
          );
        }
        return CircularIndicator(isLoading: true);
      },
    );
  }
}

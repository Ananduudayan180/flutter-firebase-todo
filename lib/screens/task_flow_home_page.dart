import 'package:flutter/material.dart';

class TaskFlowHomePage extends StatefulWidget {
  const TaskFlowHomePage({super.key});

  @override
  State<TaskFlowHomePage> createState() => _TaskFlowHomePageState();
}

class _TaskFlowHomePageState extends State<TaskFlowHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      //FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          //Full Body SizedBox
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                //Name and Profile widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      //Hi David
                      child: Row(
                        children: [
                          Text('Hi', style: themeData.textTheme.bodyMedium),
                          SizedBox(width: 5),
                          Text(
                            'David',
                            style: themeData.textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        color: themeData.scaffoldBackgroundColor,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Task $index',
                            style: themeData.textTheme.bodyLarge,
                          ),
                          subtitle: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            'Task details go here',
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
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

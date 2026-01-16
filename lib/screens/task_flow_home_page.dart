import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/widgets/circular_indicator.dart';

class TaskFlowHomePage extends StatefulWidget {
  const TaskFlowHomePage({super.key});

  @override
  State<TaskFlowHomePage> createState() => _TaskFlowHomePageState();
}

class _TaskFlowHomePageState extends State<TaskFlowHomePage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  Future<void> _logOut() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _authService.signOutUser();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } on FirebaseAuthException catch (e) {
      return ShowExceptionBar.showSnackBar(context, e.message);
    } on FirebaseException catch (e) {
      return ShowExceptionBar.showSnackBar(context, e.message);
    } finally {
      if (mounted) {
        _isLoading = false;
      }
    }
  }

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
            child: Stack(
              children: [
                Column(
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
                        CircleAvatar(
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: _isLoading
                                  ? null
                                  : () async {
                                      await _logOut();
                                    },
                              icon: Icon(Icons.logout),
                            ),
                          ),
                        ),
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
                CircularIndicator(isLoading: _isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

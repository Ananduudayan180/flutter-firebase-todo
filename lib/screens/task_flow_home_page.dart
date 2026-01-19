import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/widgets/circular_indicator.dart';
import 'package:task_flow/widgets/task_list_view.dart';

class TaskFlowHomePage extends StatefulWidget {
  final String? userName;
  const TaskFlowHomePage({super.key, this.userName});

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
                                //user Name
                                widget.userName ?? '',
                                style: themeData.textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
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
                      //task list view
                      child: TaskListView(themeData: themeData),
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

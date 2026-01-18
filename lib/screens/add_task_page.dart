import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/models/task_model.dart';
import 'package:task_flow/services/task_service.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/widgets/custom_button.dart';
import 'package:task_flow/widgets/text_form_field.dart';
import 'package:task_flow/utils/validation.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  final TaskModel? taskModel;
  const AddTaskPage({super.key, this.taskModel});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _addTaskKey = GlobalKey<FormState>();
  final TaskService _taskService = TaskService();
  TaskModel _task = TaskModel();
  final uuid = const Uuid();

  Future<void> _addTask() async {
    _task = TaskModel(
      title: _titleController.text,
      content: _descriptionController.text,
      status: 1,
      id: uuid.v4(),
      createAt: DateTime.now(),
    );
    try {
      await _taskService.addUserTask(_task);
      if (!mounted) return;
      Navigator.of(context).pop();
      ShowExceptionBar.showSnackBar(context, 'Task created');
    } on FirebaseException catch (e) {
      ShowExceptionBar.showSnackBar(context, e.message);
    }
  }

  void _ifUpdateTask() {
    _titleController.text = widget.taskModel!.title!;
    _descriptionController.text = widget.taskModel!.content!;
  }

  Future<void> _updateTask() async {
    final updatedTask = TaskModel(
      id: widget.taskModel!.id,
      title: _titleController.text,
      content: _descriptionController.text,
      status: widget.taskModel!.status,
      createAt: widget.taskModel!.createAt,
    );
    try {
      await _taskService.updateUserTask(updatedTask);
      if (!mounted) return;
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      ShowExceptionBar.showSnackBar(context, e.message);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.taskModel != null) {
      _ifUpdateTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _addTaskKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Task', style: themeData.textTheme.headlineMedium),
                const Divider(color: Colors.teal),
                //Title TextFormField
                AppTextFormField(
                  hintText: 'Title',
                  validator: Validation.taskTitleValidator,
                  controller: _titleController,
                ),
                SizedBox(height: 10),
                //Description TextFormField
                AppTextFormField(
                  hintText: 'Description',
                  validator: Validation.taskContentValidator,
                  controller: _descriptionController,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Add Task Button
                    CustomButton(
                      buttonName: 'Add Task',
                      onPressed: () async {
                        if (_addTaskKey.currentState?.validate() ?? false) {
                          //Handle add task action
                          if (widget.taskModel != null) {
                            //update Task
                            await _updateTask();
                          } else {
                            //add new task
                            await _addTask();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_flow/widgets/custom_button.dart';
import 'package:task_flow/widgets/text_form_field.dart';
import 'package:task_flow/utils/validation.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _addTaskKey = GlobalKey<FormState>();

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
                      onPressed: () {
                        if (_addTaskKey.currentState?.validate() ?? false) {
                          //Handle add task action
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

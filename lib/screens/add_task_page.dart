import 'package:flutter/material.dart';
import 'package:task_flow/screens/widgets/custom_button.dart';
import 'package:task_flow/screens/widgets/text_form_field.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Task', style: themeData.textTheme.headlineMedium),
              const Divider(color: Colors.teal),
              //Title TextFormField
              AppTextFormField(
                hintText: 'Title',
                errorMsg: 'Title is required',
                controller: _titleController,
              ),
              SizedBox(height: 10),
              //Description TextFormField
              AppTextFormField(
                hintText: 'Description',
                errorMsg: 'Description is required',
                controller: _descriptionController,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Add Task Button
                  CustomButton(buttonName: 'Add Task', onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

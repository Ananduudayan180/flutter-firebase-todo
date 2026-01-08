import 'package:flutter/material.dart';
import 'package:task_flow/screens/widgets/custom_button.dart';
import 'package:task_flow/screens/widgets/text_form_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height - kToolbarHeight - 32,
              ),
              child: Form(
                key: _signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create your Account',
                      style: themeData.textTheme.titleMedium,
                    ),
                    SizedBox(height: 10),
                    //Name TextFormField
                    AppTextFormField(
                      hintText: 'Name',
                      errorMsg: 'Name is required',
                      controller: _nameController,
                    ),
                    SizedBox(height: 10),
                    //Email TextFormField
                    AppTextFormField(
                      hintText: 'Email',
                      errorMsg: 'Email is required',
                      controller: _emailController,
                    ),
                    SizedBox(height: 10),
                    //Pass TextFormField
                    AppTextFormField(
                      hintText: 'Password',
                      errorMsg: 'Password is required',
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    //Login Button
                    CustomButton(
                      buttonName: 'Sign up',
                      onPressed: () {
                        if (_signUpKey.currentState?.validate() ?? false) {
                          //Handle sign up action
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

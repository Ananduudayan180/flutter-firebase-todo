import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/models/user_model.dart';
import 'package:task_flow/screens/widgets/custom_button.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/screens/widgets/text_form_field.dart';
import 'package:task_flow/screens/widgets/validation.dart';
import 'package:task_flow/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _signUpKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  UserModel _userModel = UserModel();
  bool isLoading = false;

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        32,
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
                          validator: Validation.nameValidator,
                          controller: _nameController,
                        ),
                        SizedBox(height: 10),
                        //Email TextFormField
                        AppTextFormField(
                          hintText: 'Email',
                          validator: Validation.emailValidator,
                          controller: _emailController,
                        ),
                        SizedBox(height: 10),
                        //Pass TextFormField
                        AppTextFormField(
                          hintText: 'Password',
                          validator: Validation.passValidator,
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        //Login Button
                        CustomButton(
                          buttonName: 'Sign up',
                          onPressed: () async {
                            //Handle sign up action
                            if (_signUpKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              //UserModel
                              _userModel = UserModel(
                                name: _nameController.text,
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                status: 1,
                                createdAt: DateTime.now(),
                              );
                              try {
                                await _auth.registerUser(_userModel);
                                if (!context.mounted) return;
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/homePage',
                                  (route) => false,
                                );
                              } on FirebaseAuthException catch (e) {
                                ShowExceptionBar.showSnackBar(
                                  context,
                                  e.message,
                                );
                              } on FirebaseException catch (e) {
                                ShowExceptionBar.showSnackBar(
                                  context,
                                  e.message,
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: isLoading,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

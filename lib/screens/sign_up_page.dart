import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/screens/widgets/custom_button.dart';
import 'package:task_flow/screens/widgets/text_form_field.dart';

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
                      onPressed: () async {
                        //Handle sign up action
                        if (_signUpKey.currentState!.validate()) {
                          final UserCredential userData = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                          if (userData.user != null) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userData.user!.uid)
                                .set({
                                  'uid': userData.user!.uid,
                                  'name': _nameController.text,
                                  'email': userData.user!.email,
                                  'createAt': DateTime.now(),
                                  'status': 1,
                                })
                                .then((value) {
                                  if (!context.mounted) return;
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/homePage',
                                    (route) => false,
                                  );
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
        ),
      ),
    );
  }
}

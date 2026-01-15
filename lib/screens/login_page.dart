import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_flow/widgets/custom_button.dart';
import 'package:task_flow/widgets/text_form_field.dart';
import 'package:task_flow/utils/validation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Log in to your Account',
                  style: themeData.textTheme.titleMedium,
                ),
                SizedBox(height: 20),
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
                  buttonName: 'Login',
                  onPressed: () async {
                    if (_loginKey.currentState!.validate()) {
                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          )
                          .then((value) {
                            if (!context.mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/homePage',
                              (route) => false,
                            );
                          });
                    }
                  },
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: themeData.textTheme.bodyLarge,
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        //Handle create account action
                        Navigator.pushNamed(context, '/signUp');
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

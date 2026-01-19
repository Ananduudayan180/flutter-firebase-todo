import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/models/user_model.dart';
import 'package:task_flow/services/auth_service.dart';
import 'package:task_flow/utils/snack_bar.dart';
import 'package:task_flow/widgets/circular_indicator.dart';
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
  bool _isLoading = false;
  UserModel _userModel = UserModel();
  final AuthService _auth = AuthService();

  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    //UserModel
    _userModel = UserModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    try {
      await _auth.loginUser(_userModel);
      SharedPreferences pref = await SharedPreferences.getInstance();
      final userName = pref.getString('name');
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
        (route) => false,
        arguments: userName,
      );
    } on FirebaseAuthException catch (e) {
      ShowExceptionBar.showSnackBar(context, e.message);
    } on FirebaseException catch (e) {
      ShowExceptionBar.showSnackBar(context, e.message);
    } on Exception catch (e) {
      ShowExceptionBar.showSnackBar(context, e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Form(
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
                        if (!_isLoading && _loginKey.currentState!.validate()) {
                          await _loginUser();
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
              CircularIndicator(isLoading: _isLoading),
            ],
          ),
        ),
      ),
    );
  }
}

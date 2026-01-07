import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: SizedBox(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _emailController,
                  style: themeData.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: themeData.textTheme.bodyMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              //Pass TextFormField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: themeData.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: themeData.textTheme.bodyMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              //Login Button
              InkWell(
                onTap: () {
                  //Login action
                  if (_loginKey.currentState?.validate() ?? false) {}
                },
                child: Container(
                  height: 48,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Login', style: themeData.textTheme.bodyLarge),
                  ),
                ),
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
    );
  }
}

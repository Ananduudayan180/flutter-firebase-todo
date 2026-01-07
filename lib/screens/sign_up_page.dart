import 'package:flutter/material.dart';

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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _nameController,
                  style: themeData.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: themeData.textTheme.bodyMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
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
                  // Sign up action
                  if (_signUpKey.currentState?.validate() ?? false) {}
                },
                child: Container(
                  height: 48,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Sign up',
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

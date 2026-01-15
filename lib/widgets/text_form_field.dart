import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final bool obscureText;

  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      style: themeData.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: themeData.textTheme.bodyMedium,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: validator,
    );
  }
}

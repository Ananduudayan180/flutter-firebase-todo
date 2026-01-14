import 'package:flutter/material.dart';

class ShowExceptionBar {
  static void showSnackBar(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Something went wrong. Please try again.'),
      ),
    );
  }
}

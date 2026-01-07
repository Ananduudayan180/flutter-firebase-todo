import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(buttonName, style: themeData.textTheme.bodyLarge),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final bool isLoading;
  const CircularIndicator({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(visible: isLoading, child: const CircularProgressIndicator()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    final userName = pref.getString('name');
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    if (token != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/homePage',
        (route) => false,
        arguments: userName,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text('Task Flow', style: themeData.textTheme.headlineMedium),
      ),
    );
  }
}

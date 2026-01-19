import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_flow/screens/add_task_page.dart';
import 'package:task_flow/screens/splash_page.dart';
import 'package:task_flow/screens/task_flow_home_page.dart';
import 'package:task_flow/screens/login_page.dart';
import 'package:task_flow/screens/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Color(0xff0E1D3E),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        // '/homePage': (context) => TaskFlowHomePage(),
        '/addTask': (context) => AddTaskPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/homePage') {
          final userName = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (_) => TaskFlowHomePage(userName: userName),
          );
        }
        return null;
      },
    );
  }
}

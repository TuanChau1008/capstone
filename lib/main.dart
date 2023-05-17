import 'package:capstone/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';
import 'login_screen/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        '/': (context) => const LoginScreen(),
        '/signUpScreen': (context) => const SignupScreen(),
        '/homeScreen': (context) => const HomeScreen(),
      },
    );
  }
}

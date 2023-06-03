import 'package:capstone/home_screen/task_history.dart';
import 'package:capstone/information_screen/change_password.dart';
import 'package:capstone/information_screen/edit_info.dart';
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
        '/': (context) => const Change_Password(),
        '/signUpScreen': (context) => const SignupScreen(),
        '/homeScreen': (context) => const HomePage(),
        // '/taskHistory': (context) => const History(),
        '/editProfile': (context) => const Edit_info(),
        '/changePassword': (context) => const Change_Password(),
      },
    );
  }
}

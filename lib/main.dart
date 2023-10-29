import 'package:capstone/history_screen/task_history.dart';
import 'package:capstone/home_screen/homescreen.dart';
import 'package:capstone/information_screen/change_password.dart';
import 'package:capstone/information_screen/edit_info.dart';
import 'package:capstone/login_screen/login_screen.dart';
import 'package:capstone/notification_screen/notification_screen.dart';
import 'package:capstone/information_screen/profile.dart';
import 'package:capstone/qr_scanner/qr_scanner.dart';
import 'package:capstone/splash_screen.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        // '/': (context) => const Change_Password(),
        '/': (context) =>  const SplashScreen(),
        '/loginSceen': (context) => const LoginScreen(),
        '/signUpScreen': (context) => const SignupScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/taskHistory': (context) => const History(),
        '/editProfile': (context) => const Edit_info(),
        '/sqScanner': (context) => const QRscanner(),
        '/notification': (context) => const Notificaiton(),
        '/profile': (context) => const Info(),
        '/changePassword': (context) => const Change_Password(),
      },
    );
  }
}

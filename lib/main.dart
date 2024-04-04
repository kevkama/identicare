import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:identicare/auth/auth.dart';
import 'package:identicare/auth/login_or_signup.dart';
import 'package:identicare/firebase_options.dart';
import 'package:identicare/screens/homepage.dart';
import 'package:identicare/screens/profile.dart';
import 'package:identicare/screens/users.dart';
import 'package:identicare/theme/dark_mode.dart';
import 'package:identicare/theme/light_mode.dart';

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
      home: const Authpage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_or_signup':(context) => const LoginOreSignUp(),
        '/homepage':(context) =>  HomePage(),
        '/profile':(context) => Profile(),
        '/users':(context) => const Users(),
      },
    );
  }
}

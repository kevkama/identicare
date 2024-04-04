import 'package:flutter/material.dart';
import 'package:identicare/screens/login.dart';
import 'package:identicare/screens/signup.dart';

class LoginOreSignUp extends StatefulWidget {
  const LoginOreSignUp({super.key});

  @override
  State<LoginOreSignUp> createState() => _LoginOreSignUpState();
}

class _LoginOreSignUpState extends State<LoginOreSignUp> {
  // show login page first
  bool showLogin = true;

  // then toggle between the two pages
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(onTap: togglePages);
    } else {
      return SignUp(onTap: togglePages);
    }
  }
}

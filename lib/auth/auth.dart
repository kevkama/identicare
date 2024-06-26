import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:identicare/auth/login_or_signup.dart";
import "package:identicare/screens/my_bottom_nav.dart";

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user loggedin?
          if (snapshot.hasData) {
            return const MyBottomNav();
          }

          // if not
          else {
            return const LoginOreSignUp();
          }
        },
      ),
    );
  }
}

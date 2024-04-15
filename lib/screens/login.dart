// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identicare/auth/services/auth_services.dart';
import 'package:identicare/components/my_button.dart';
import 'package:identicare/components/my_textfield.dart';
import 'package:identicare/helper/helper_functions.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  // the textediting controller

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login method
  void login() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // try login
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop loading circle
      Navigator.pop(context);
    }

    // in case of errors display
    on FirebaseAuthException catch (e) {
      // pop it again
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // logo
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // app name
                  const Text(
                    "IDENTICARE",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // email textfield
                  MyTextField(
                    hintText: "E-mail",
                    labelText: "E-mail",
                    obscureText: false,
                    controller: emailController,
                    prefixIcon: const Icon(Icons.mail),
                    suffixIcon: null,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // password textfield

                  MyTextField(
                    hintText: "Password",
                    labelText: "Password",
                    obscureText: isHidden,
                    controller: passwordController,
                    prefixIcon: null,
                    suffixIcon: InkWell(
                      onTap: togglePassword,
                      child: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // forgot password tap  text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // sign in button
                  MyButton(
                    text: "Login",
                    onTap: login,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // don't have an account register tap text

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    indent: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Or"),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => AuthServices().signInWithGoogle(),
                    child: Container(
                      width: 210,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 74, 32),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Row(
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Sign in with google",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

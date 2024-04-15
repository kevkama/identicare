// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identicare/auth/services/auth_services.dart';
import 'package:identicare/components/my_button.dart';
import 'package:identicare/components/my_textfield.dart';
import 'package:identicare/helper/helper_functions.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;

  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHidden = true;
  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }
  // the textediting controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController confirmPWController = TextEditingController();

  // sign up method
  Future<void> signUpUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // then make sure password match
    if (passwordController.text != confirmPWController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error msg to user
      displayMessageToUser("Passwords don't match!", context);
    } else { 
      // try creating the user
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
                

        // create a user doc and add to firestore
        createUserDocument(userCredential);

        // pop the circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop circle again
        Navigator.pop(context);

        // by displaying msg to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  // create user doc and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'userName': usernameController.text,
      });
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
                mainAxisAlignment: MainAxisAlignment.center,
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

                  // user name textfield
                  MyTextField(
                    hintText: "User Name",
                    labelText: "User Name",
                    obscureText: false,
                    controller: usernameController, 
                    prefixIcon: const Icon(Icons.person), 
                    suffixIcon: null,
                  ),

                  const SizedBox(
                    height: 10,
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
                        isHidden
                        ?Icons.visibility_off
                        :Icons.visibility)
                      ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // confirm password textfield

                  MyTextField(
                    hintText: "Confirm Password",
                    labelText: " Confirm Password",
                    obscureText: isHidden,
                    controller: confirmPWController, 
                    prefixIcon: null, 
                    suffixIcon: InkWell(
                      onTap: togglePassword,
                      child: Icon(
                        isHidden
                        ?Icons.visibility_off
                        :Icons.visibility)
                      ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // sign in button
                  MyButton(
                    text: "Sign Up",
                    onTap: signUpUser,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // don't have an account register tap text

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                          "Login Here",
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

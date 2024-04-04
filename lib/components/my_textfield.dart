
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: hintText,
        labelText: labelText,
      ),

    );
  }
}

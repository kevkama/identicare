import 'package:flutter/material.dart';

// displaying error msg to user
void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

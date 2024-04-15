import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_button.dart';
import 'package:identicare/components/my_textfield.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    // only post when textfield has data
    if (newPostController.text.isNotEmpty) {
      // store the new data
      FirebaseFirestore.instance.collection("Posts").add({
        "userEmail": currentUser!.email,
        "PostMessage": newPostController.text,
        "TimeStamp": Timestamp.now(),
      });
    }
    newPostController.clear();
    Navigator.popAndPushNamed(context, '/bottomnav');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Post a message here",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: MyTextField(
                    hintText: "Share your insights",
                    labelText: "Post",
                    obscureText: false,
                    controller: newPostController,
                    prefixIcon: null,
                    suffixIcon: null),
              ),
              MyButton(text: "Post", onTap: postMessage),
              const SizedBox(height: 50,)
            ],
          ),
        ));
  }
}

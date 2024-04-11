import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_drawer.dart';
import 'package:identicare/components/my_post_button.dart';
import 'package:identicare/components/my_textfield.dart';
import 'package:identicare/components/post_wall.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController newPostController = TextEditingController();

  // post message method
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(appBarBuilder: (context) {
        return AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "IDENTICARE",
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          actions: const [AppBarSearchButton()],
        );
      }),
      drawer: MyDrawer(),
      body: Stack(
        children: [
          CupertinoPageScaffold(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Posts")
                          .orderBy(
                            "TimeStamp",
                            descending: true,
                          )
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.docs[index];
                              return PostWall(
                                message: post["PostMessage"],
                                user: post["userEmail"],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error:${snapshot.error}"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextField(
                              hintText: "Share your insights",
                              labelText: "Post",
                              obscureText: false,
                              controller: newPostController,
                              prefixIcon: null,
                              suffixIcon: null),
                        ),
                        MyPostButton(onTap: postMessage),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

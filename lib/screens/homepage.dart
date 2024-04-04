import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_drawer.dart';
import 'package:identicare/components/my_list_tile.dart';
import 'package:identicare/components/my_post_button.dart';
import 'package:identicare/components/my_textfield.dart';
import 'package:identicare/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //  accesing the fire store
  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // place for the user to type a post
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      hintText: "Your thoughts?",
                      labelText: "post",
                      obscureText: false,
                      controller: newPostController),
                ),
                MyPostButton(
                  onTap: postMessage,
                )
              ],
            ),
          ),
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // show the loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // cater for no data instance
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No Posts.. Post Something!"),
                  ),
                );
              }

              // retun the list of posts
              return Expanded(
                  child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  // get each individual post
                  final post = posts[index];

                  // retrieve data from each post
                  String message = post['PostMessage'];
                  String userName = post['userName'];
                  Timestamp timestamp = post['TimeStamp'];

                  // return the data as a list tile
                  return MyListTile(title: userName, subTitle: message);
                },
              ));
            },
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_drawer.dart';
import 'package:identicare/components/my_list_tile.dart';
import 'package:identicare/components/my_post_button.dart';
import 'package:identicare/components/my_textfield.dart';
import 'package:identicare/database/firestore.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  accesing the fire store
  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  var searchName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(onChanged: (value) {
        setState(() {
          searchName = value;
        });
      }, appBarBuilder: (context) {
        return AppBar(
          title: const Text(
            "IDENTICARE",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          actions: const [AppBarSearchButton()],
        );
      }),
      drawer: MyDrawer(),
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
                      controller: newPostController,
                      prefixIcon: null,
                      suffixIcon: null),
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
                  String username = post['userName'];
                  Timestamp timestamp = post['TimeStamp'];

                  // return the data as a list tile
                  return MyListTile(
                    title: username,
                    subTitle: message,
                  );
                },
              ));
            },
          )
        ],
      ),
    );
  }
}

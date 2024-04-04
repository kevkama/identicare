import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_back_button.dart';
import 'package:identicare/components/my_list_tile.dart';
import 'package:identicare/helper/helper_functions.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // display errors if any
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }

          // show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Text("No Data");
          }

          // then get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 25),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // list of users
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    final user = users[index];

                    // get data from each user
                    String username = user['userName'];
                    String email = user['email'];

                    return MyListTile(
                      title: username, 
                      subTitle: email,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:identicare/components/my_drawer.dart';
import 'package:identicare/components/post_wall.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
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
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

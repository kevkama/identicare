import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('PostMessage')
              .startAt([searchName]).endAt(['$searchName/uf8ff']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 24,
                  ),
                  title: Text(data['PostMessage']),
                  subtitle: Text(data['PostMessage']),
                );
              },
            );
          }),
    );
  }
}

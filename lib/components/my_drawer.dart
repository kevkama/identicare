import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // header
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  // navigate to users
                  Navigator.pushNamed(context, '/profile');
                },
                child: DrawerHeader(
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: getUserDetails(),
                    builder: (context, snapshot) {
                      // show a loading.. shimmer
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // errors
                      else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      }

                      // get data
                      else if (snapshot.hasData) {
                        // extract data from current user
                        Map<String, dynamic>? user = snapshot.data!.data();
                        return Center(
                          child: Row(
                            children: [
                              // profile pic
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: const Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              // username
                              Padding(
                                padding: const EdgeInsets.only(top:25),
                                child: Column(
                                  children: [
                                    Text(
                                      user!['userName'],
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    // their email
                                    Text(
                                      user['email'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Text("No data");
                      }
                    },
                  ),
                ),
              ),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // user tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("C O M M U N I T I E S"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("EVENTS &  CHARITIES"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("TELEHEALTH"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),

          // logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);

                // logout
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
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
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
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

              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person_4_outlined),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),

              // logout
              const SizedBox(
                height: 20,
              ),
            ],
          ),

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

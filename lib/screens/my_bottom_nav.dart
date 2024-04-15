import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:identicare/screens/homepage.dart';
import 'package:identicare/screens/postpage.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({super.key});

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const PostPage(),
    const HomePage(),
    const PostPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: const Color.fromARGB(255, 4, 199, 199),
      animationDuration: const Duration(milliseconds: 400),
      onTap: (index) {
        setState(() {
          selectedIndex = index;          
        });        
      },      
      items: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.home,
                size: 20,
              ),
              Text('Home'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.add_box_outlined,
                size: 20,
              ),
              Text('Post'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.chat_bubble_outline,
                size: 20,
              ),
              Text('Chat'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.settings,
                size: 20,
              ),
              Text('settings'),
            ],
          ),
        ),
      ],
    ),
    body: pages[selectedIndex],    
    );
  }
}

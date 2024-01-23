import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Pages/Call/Calls.dart';
import 'package:graduation_project/Pages/Chats/Chat.dart';
import 'package:graduation_project/Pages/Profile/ProfilePage.dart';
import 'package:graduation_project/Pages/Settiing/Setting.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}
class HomePageState extends State<HomePage>{
  int currentIndexx = 0;
  List<Widget> get pages => [
    Profile(),
    Chat(),
    Calls(),
    Setting(),
  ];
  bool get showAppBar => currentIndexx == 0; //  Show app bar only for the home page (index 0)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Home Page"),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple.shade500,
        currentIndex: currentIndexx,
        onTap: (index) {
          setState(() {
            currentIndexx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile Page",
            backgroundColor: Colors.purple.shade100,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search Page",
            backgroundColor: Colors.purple.shade100,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat Page",
            backgroundColor: Colors.purple.shade100,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
            backgroundColor: Colors.purple.shade100,
          ),
        ],
      ),
      body: pages[currentIndexx],
    );
  }
}
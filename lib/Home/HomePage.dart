import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Pages/Call/Calls.dart';
import 'package:graduation_project/Pages/Chats/Chat.dart';
import 'package:graduation_project/Pages/Profile/ProfilePage.dart';
import 'package:graduation_project/Pages/Settiing/Setting.dart';

import '../Pages/Chats/ZegoChat.dart';

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
    CallPage(callID: ""),
    ZegoChat(),
  //  Setting(),
  ];
  bool get showAppBar => currentIndexx == 0; //  Show app bar only for the home page (index 0)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        backgroundColor: Colors.blue.shade50,
       // title: Text("Home Page"),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue.shade100,
        currentIndex: currentIndexx,
        onTap: (index) {
          setState(() {
            currentIndexx = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 25,color: Colors.blue.shade900,),
            label: "Profile ",
            backgroundColor: Colors.blue.shade50,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call,size: 25,color: Colors.blue.shade900,),
            label: "Call ",
            backgroundColor: Colors.blue.shade50,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,size: 25,color: Colors.blue.shade900,),
            label: "Chat ",
            backgroundColor: Colors.blue.shade50,
          ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings,size: 25,color: Colors.blue.shade900,),
      //       label: "Setting",
      //       backgroundColor: Colors.blue.shade50,
      //     ),
         ],
       ),
      body: pages[currentIndexx],
    );
  }
}
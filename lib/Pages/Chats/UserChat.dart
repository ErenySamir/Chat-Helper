import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../Chats/ZIMKitDemoHomePage.dart';

class UserChat extends StatefulWidget{
  @override
  State<UserChat> createState() {
    return UserChatState();
  }

}
class UserChatState extends State<UserChat>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
          title: Text("Chat between 2 users  "),
        ),
        body:  ElevatedButton(
          onPressed: () async {
            await ZIMKit()
                .connectUser(id:'1925638511', name: 'ereny');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                const ZIMKitDemoHomePage(),
              ),
            );
          },
          child: const Text("send"),
        )
    );
  }

}
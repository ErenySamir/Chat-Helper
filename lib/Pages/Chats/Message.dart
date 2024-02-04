import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessageWidget extends StatelessWidget{
  final String? msg;
  final String? sender;
  final String? previousName;
  final String? User_Name;
  final String? User_Tybe;

  var auth = FirebaseAuth.instance;

  MessageWidget({this.sender,this.msg,this.previousName,this.User_Name,this.User_Tybe});
  @override
  Widget build(BuildContext context) {
    // final isSender = sender == previousName;

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
            color: sender == auth.currentUser!.email ? Colors.brown.shade50 : Colors.greenAccent,
            borderRadius: BorderRadius.circular(25),
            child: Text(msg!),
          ),
        ),
        (previousName!=sender)?Padding
          (padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(sender!,style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 12,
            ),)
        ):Container(
          alignment: sender == previousName ? Alignment.centerRight : Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        )

      ],
    );
  }
}
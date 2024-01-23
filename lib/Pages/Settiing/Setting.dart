import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget{
  @override
  State<Setting> createState() {
    return SettingState();
  }

}
class SettingState extends State<Setting>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Setting"),
      ),

    );
  }

}
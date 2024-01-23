import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calls extends StatefulWidget{
  @override
  State<Calls> createState() {
    return CallsState();
  }

}
class CallsState extends State<Calls>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text("Calls"),
      ),
    );
  }

}
import 'dart:async';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Login/LogIn.dart';
import 'package:graduation_project/Login/LoginTest.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}
class SplashScreenState extends State<SplashScreen>{
  int counter=0;
  @override
  //this function بتاخر الحاجه اللي جواها لمده انا اللي بحددها
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4),(){
      //HomeScreen تفتح  بعد 4 دقايق
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginTest(),
        ),
      );
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          title: Text("Welcome")),
        body: Center(
          child: Image.asset('assets/images/splash.jpg'),
        ) );
  }
}
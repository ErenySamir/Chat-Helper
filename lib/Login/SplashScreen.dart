import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LoginTest.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5 ),
            (){
          Get.to(LoginTest());
        });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: Column( crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5,
                    child: Image.asset('assets/images/welcomeScreen.jpg' ,)),
                Expanded( flex: 1,
                  child: Text('Chat App' ,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold ,
                        fontFamily: "Font_Stranger" , fontSize: 30),),
                ),
                // SizedBox(height: 10,),
                Expanded(flex: 1,
                  child: SizedBox(width: 300,
                      child: Text('Enjoy to Chating and Calling with your helper' ,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,
                          fontFamily: "Font_Hey" , fontSize: 20 , ),)),
                ),
              ],
            )),
      ),
    );
  }
}
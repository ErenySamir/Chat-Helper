import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutterfirebase/logintest.dart';
// import 'package:flutterfirebase/welcometest.dart';
import 'package:get/get.dart';

import '../Home/HomePage.dart';
import '../Login/LoginTest.dart';

class AuthController extends GetxController{
  //AuthController Instance
  static AuthController instance = Get.find();

  //email , Password
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);

    // the user would be notified "when logOut, logIn"
    _user.bindStream(auth.userChanges());
    //when change logout and login by ever we notified
    ever(_user,  _initialscreen);
  }

  _initialscreen(User? user){
    if(user==null){
      print('login page');
      Get.offAll(()=> LoginTest());
    }else{
      Get.offAll(() => HomePage());
    }
  }

  Future<void> register(String email , password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(e){
      Get.snackbar('About User', 'User message' ,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM ,
          titleText: Text(
            'Account creation failed' ,
            style: TextStyle(
              color: Colors.white,
            ),),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),)
      );

    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutterfirebase/logintest.dart';
// import 'package:flutterfirebase/welcometest.dart';
import 'package:get/get.dart';

import '../Home/HomePage.dart';
import '../Login/LogIn.dart';
import '../Login/UserRegister.dart';

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
      Get.offAll(()=> LogIn());
    }else{
      Get.offAll(() => HomePage());
    }
  }

  register(String email , password) async {
    try{      print(email+'hhh');

    await auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;

      fireStore.collection("DataEntered").add({
        'Name': 'test',
        'userName': auth.currentUser!.email,
        'time': DateTime.now(),

      });
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
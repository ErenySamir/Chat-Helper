import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Login/LogIn.dart';
import 'package:graduation_project/Login/Register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initializeApp بستخدمه دايما مع فايربييز
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCmFIyuzaiTZpU9rnWdC-ai5f264PgeCU8",
          authDomain: "chat-helper-2026c.firebaseapp.com",
          projectId: "chat-helper-2026c",
          storageBucket: "chat-helper-2026c.appspot.com",
          messagingSenderId: "470462396570",
          appId: "1:470462396570:web:604baa40b6f007b53e8723",
          measurementId: "G-86RE3D9SL6"
      )
  );

  //shared prefrence to sheck if user loged in before or not
  // SharedPreferences.getInstance().then((value){
  //email= value.getString("email").toString();
  //email = 'null';
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    )
  );
}
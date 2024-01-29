import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graduation_project/Login/LogIn.dart';
import 'package:graduation_project/Login/Register.dart';
import 'package:graduation_project/Login/SplashScreen.dart';
import 'package:graduation_project/Pages/Settiing/Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login/LoginTest.dart';
import 'Pages/Chats/Chat.dart';
import 'Pages/Helper/Helper.dart';

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
  // String email="";
  // SharedPreferences.getInstance().then((value) {
  //   email = value.getString("email").toString();
  //   email = 'null';
  return runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:LoginTest(),
      )
  );
}

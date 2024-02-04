import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:graduation_project/Login/LogIn.dart';
import 'package:graduation_project/Login/Register.dart';
import 'package:graduation_project/Login/UserRegister.dart';
import 'package:graduation_project/Pages/Chats/ZegoChat.dart';
import 'package:graduation_project/Pages/Chats/test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'Home/HomePage.dart';
import 'Login/SplashScreen.dart';
import 'Pages/Chats/Chat.dart';
import 'Pages/Settiing/ThemeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(name: 'chat',
    options: FirebaseOptions(
        apiKey: "AIzaSyCmFIyuzaiTZpU9rnWdC-ai5f264PgeCU8",
        authDomain: "chat-helper-2026c.firebaseapp.com",
        projectId: "chat-helper-2026c",
        storageBucket: "chat-helper-2026c.appspot.com",
        messagingSenderId: "470462396570",
        appId: "1:470462396570:web:604baa40b6f007b53e8723",
        measurementId: "G-86RE3D9SL6"
    ),
  );
  // Initialize Zego
  ZIMKit().init(
    appID: 1925638511, // your appid
    appSign: '41a41e8993fcc270a4153ac167d83dc35a6b3bbb164fb18adccf7f80e83a0298', // your appSign
  );

  // Get user email from SharedPreferences
  String email = "";
  SharedPreferences.getInstance().then((value) {
    email = value.getString("email").toString();
    email = 'null';

    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: MyApp(),
      ),
    );
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //theme: Provider.of<ThemeProvider>(contex),
    );
  }
}
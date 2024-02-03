import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
  await Firebase.initializeApp(
    options: FirebaseOptions(

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
      home: Chat(),
      //theme: Provider.of<ThemeProvider>(contex),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final themeLight = ThemeData(
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
    //iconTheme: IconThemeData(color: Colors.blue[900]),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    )))),
  );

  static final themeDark = ThemeData(
      scaffoldBackgroundColor: Colors.indigo[700],
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.blue))))));
}

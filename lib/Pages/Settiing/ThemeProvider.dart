import 'package:flutter/material.dart';

import 'DarkorLight.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightData;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }


  void toggleTheme(){
    if(_themeData == lightData){
      themeData = DarkData;
    }else{
      themeData = lightData;
    }
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Setting extends StatefulWidget{
//   @override
//   State<Setting> createState() {
//     return SettingState();
//   }
//
// }
// class SettingState extends State<Setting>{
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple.shade100,
//         title: Text("Setting"),
//       ),
//
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Thems.dart';



class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Center(
          child: SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value); // Pass the value argument to toggleTheme()
            },
          ),
        ),
      ),
    );
  }
}
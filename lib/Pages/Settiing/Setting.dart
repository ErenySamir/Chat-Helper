import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Thems.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: IconButton(
        icon: Icon(Icons.start),
        onPressed: () {
          Provider.of<Themes>(context, listen: false).toggleTheme();
        },
      ),
    );
  }
}
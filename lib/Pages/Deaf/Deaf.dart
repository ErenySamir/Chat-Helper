import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deaf extends StatefulWidget{
  @override
  State<Deaf> createState() {
return DeafState();
  }

}
class DeafState extends State<Deaf>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.blue.shade100,
   );
  }

}
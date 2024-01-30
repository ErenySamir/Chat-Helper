import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Deaf extends StatefulWidget {
  @override
  State<Deaf> createState() {
    return DeafState();
  }
}

class DeafState extends State<Deaf> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<String> documentIds = [];
  List<Map<String, dynamic>> userDataList = [];

  @override
  void initState() {
    super.initState();
    getResipes();
  }

  getResipes() async {
    var response = await fireStore.collection("DataEntered").get();

    response.docs.forEach((doc) {
      setState(() {
        documentIds.add(doc.id);
        userDataList.add(doc.data() as Map<String, dynamic>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: ListView.builder(
          itemCount: documentIds.length,
          itemBuilder: (context, index) {
            String documentId = documentIds[index];
            Map<String, dynamic> userData = userDataList[index];

            return ListTile(
              title: Text('Document ID: $documentId',style: TextStyle(
                  fontSize: 18,
                  height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                  color: Colors.redAccent, //font color
                  backgroundColor: Colors.black12, //background color
                  letterSpacing: 5, //letter spacing
                  decoration: TextDecoration.underline, //make underline
                  decorationStyle: TextDecorationStyle.double, //double underline
                  decorationColor: Colors.brown, //text decoration 'underline' color
                  decorationThickness: 1.5, //decoration 'underline' thickness
                  fontStyle: FontStyle.italic
              ), ),
              subtitle: Text('Data: ${userData.toString()}',style: TextStyle(
                  fontSize: 18,
                  height: 2, //line height 200%, 1= 100%, were 0.9 = 90% of actual line height
                  color: Colors.redAccent, //font color
                  backgroundColor: Colors.black12, //background color
                  letterSpacing: 5, //letter spacing
                  decoration: TextDecoration.underline, //make underline
                  decorationStyle: TextDecorationStyle.double, //double underline
                  decorationColor: Colors.brown, //text decoration 'underline' color
                  decorationThickness: 1.5, //decoration 'underline' thickness
                  fontStyle: FontStyle.italic
              ),),
            );
          },
        ),
      ),
    );
  }
}
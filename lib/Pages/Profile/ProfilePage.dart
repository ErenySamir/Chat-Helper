import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProfileWidget.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  String emailshared = "";
  String nameshared = "";
  ImageProvider? galleryImage;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailshared = prefs.getString("email") ?? "";
      nameshared = prefs.getString("name") ?? "";
    });
  }

  Future<void> openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        galleryImage = MemoryImage(imageBytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     setState(() {
          //       isDarkMode = !isDarkMode;
          //     });
          //   },
          //   // Use isDarkMode to change the icon
          //   icon: Icon(
          //     isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars,
          //     color: isDarkMode ? Colors.white : Colors.black,
          //   ),
          // ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            image: galleryImage ?? NetworkImage(''), // Provide a default image URL here if needed
            imagePath: '', // Provide a default image path here if needed
            onClicked: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Upload from Gallery'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          GestureDetector(
                            child: Text('Gallery'),
                            onTap: () {
                              openGallery();
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(height: 10),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: [
              Text(
                '$nameshared ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.blue.shade900),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '$emailshared ',
                style: TextStyle(color: Colors.blue.shade900),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
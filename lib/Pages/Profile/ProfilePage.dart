import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../Chats/ZIMKitDemoHomePage.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  //open gallery
  Uint8List? galleryImage;

  Future<void> openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        galleryImage = imageBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
          title: Text("Profile "),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return IconButton(
              onPressed: openGallery,
              icon: Icon(
                Icons.photo,
                color: Colors.blue.shade900,
                size: 25,
              ),
            );
          },
        ),
    //     SizedBox(height: 46.0),
    //     if (galleryImage != null)
    //    Image.memory(
    //   galleryImage!,
    //   height: 250,
    //   width: 250,
    // ),

    );
  }
}
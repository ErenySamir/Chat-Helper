import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final ImageProvider image;
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    required this.image,
    required this.imagePath,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: CircleAvatar(
        radius: 80,
        backgroundImage: image,
        child: imagePath.isEmpty
            ? const Icon(
          Icons.person,
          size: 80,
          color: Colors.grey,
        )
            : null,
      ),
    );
  }
}
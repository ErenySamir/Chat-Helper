import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Controller/ChatController.dart';
import '../Call/Calls.dart';
import 'Message.dart';

class Chat extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController messageTxt = TextEditingController();
  String? previousResponse;
  int currentIndex = 0;
  late ChatController chatController;

  // To open gallery
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

  // Show all chat on the screen
  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: Text('Chat Helper'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //when click in icon of calll open call page and start call when click on btn in call page
                SizedBox(
                  width: 50, // Set a specific width
                  child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (int index) {
                      setState(() {
                        chatController.currentIndex = index;
                      });
                      if (chatController.currentIndex == 0) {
                        // Navigate to the call page
                        chatController.navigateToCallPage();
                      } else {
                        print("call failed ");
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.call),
                        label: "Call",
                        backgroundColor: Colors.blue.shade200,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.video_call),
                        label: "Video Call",
                        backgroundColor: Colors.blue.shade200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: fireStore
                    .collection('MessageID')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final responseMessage = snapshot.data!.docs;
                    final allMessages = responseMessage.map((message) {
                      final txt = message.get('msg') as String;
                      final sender = message.get('userName') as String;
                      final messageWidget = MessageWidget(
                        msg: txt,
                        sender: sender,
                        previousName: previousResponse,
                      );
                      previousResponse = sender;
                      return messageWidget;
                    }).toList();

                    return ListView(
                      children: allMessages,
                      reverse: true,
                    );
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.greenAccent,
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTxt,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Write your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      fireStore.collection("MessageID").add({
                        'userName': auth.currentUser!.email,
                        'msg': messageTxt.text.toString(),
                        'time': DateTime.now(),
                      });
                      messageTxt.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue.shade800,
                      size: 50,
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return IconButton(
                        onPressed: openGallery,
                        icon: Icon(
                          Icons.photo,
                          size: constraints.maxHeight,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 46.0),
                  if (galleryImage != null)
                    Image.memory(
                    galleryImage!,
                    height: 250,
                    width: 250,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
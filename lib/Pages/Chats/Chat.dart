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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //when click in icon of calll open call page and start call when click on btn in call page
                SizedBox(
                  width: 400, // Set a specific width
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
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
                          icon: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.call,
                              size: 25,
                              color: Colors.blue.shade900,

                            ),
                          ),
                          label: "Voice Call",
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.video_call,
                              size: 25,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          label: "Video Call",
                        ),
                      ],
                    ),
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
                  //List<Text>allMessages=[]; this line  to avoid repeat data
                  List<MessageWidget> allMessages = [];
                  if (snapshot.hasData) {
                    var responseMessage = snapshot.data!.docs;
                    print(responseMessage.length.toString() + 'chatlength');
                    for (int i = 0; i < responseMessage.length; i++) {
                      String txt = responseMessage[i].get('msg');
                      String Sender = responseMessage[i].get('userName');
                      if (i > 0) {
                        previousResponse =
                            responseMessage[i - 1].get('userName');
                      }
                      allMessages.add(MessageWidget(
                          msg: txt,
                          sender: Sender,
                          previousName: previousResponse));
                    }
                    return Expanded(
                      child: ListView(
                        // scrollDirection: Axis.vertical,shrinkWrap: true -> دول بحظهم لو انا هسييب الليست فاضيه
                        children: allMessages,
                        reverse: true,
                      ),
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
                      color: Colors.blue.shade900,
                      size: 50,
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return IconButton(
                        onPressed: openGallery,
                        icon: Icon(
                          color: Colors.blue.shade900,
                          Icons.photo,
                          size: 25,
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

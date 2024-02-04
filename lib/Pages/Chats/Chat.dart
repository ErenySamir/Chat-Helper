import 'dart:async';
import 'dart:typed_data';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
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
  //get name & msg
  TextEditingController messageTxt = TextEditingController();
  TextEditingController NameTxt = TextEditingController();

  String? previousResponse;
  int currentIndex = 0;
  late ChatController chatController;
  //allow to send files
  final List<XFile> listofFiles = [];
  List<String> messages = [];

  bool dragging = false;
  // To open gallery
  Uint8List? galleryImage;
  ScrollController _scrollController = new ScrollController();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Community'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [  IconButton(
                    color: Colors.blue.shade900, onPressed: () {
                    chatController.navigateToCallPage();
                  }, icon: Icon(Icons.video_call),
                  ),
                    Text("Video Call"),
                    //when click in icon of calll open call page and start call when click on btn in call page


                  ],
                ),
              ),
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
                    // Navigator.pop(context);
                    var responseMessage = snapshot.data!.docs;
                    print(responseMessage.length.toString() + 'chatlength');
                    for (int i = 0; i < responseMessage.length; i++) {
                      String txt = responseMessage[i].get('msg');
                     // String Sender = responseMessage[i].get('userName');
                      String Name = responseMessage[i].get('Name');
                     // String type = responseMessage[i].get('type');


                      if (i > 0) {
                        previousResponse =
                            responseMessage[i - 1].get('Name');
                      }
                       allMessages.add(MessageWidget(sender: Name,
                           msg: txt,
                          User_Name: Name,
                           previousName: previousResponse));
                     }
                    return 
                      Scaffold(
                        body: Expanded(
                        child: ListView(
                          controller: _scrollController,

                          // scrollDirection: Axis.vertical,shrinkWrap: true -> دول بحظهم لو انا هسييب الليست فاضيه
                          children: allMessages,
                         // reverse: true,
                        ),
                                            ),
                      );
                  } else {
                    return Center(
                      child: AlertDialog(
                            content: new Row(
                              children: [
                                CircularProgressIndicator(),
                                Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
                              ],),
                          ),
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
                        'Name':'ereny',
                        'time': DateTime.now(),

                      });
                      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);

                      messageTxt.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue.shade900,
                      size: 50,
                    ),
                  ),
  //*************************************************************************
                  //draggg files
                  // GestureDetector(
                  //   onTap: () async {
                  //     // Handle the file sending logic here
                  //     if (listofFiles.isEmpty) {
                  //       // Select file
                  //       FilePickerResult? result = await FilePicker.platform.pickFiles();
                  //
                  //       if (result != null && result.files.isNotEmpty) {
                  //         setState(() {
                  //           listofFiles.addAll(result.files.map((file) => XFile(file.name)));
                  //           listofFiles.addAll(result.files.map((file) => XFile(file.name)));
                  //         });
                  //       }
                  //     } else {
                  //       // Send the files
                  //       // Implement your file sending logic here
                  //       // You can access the list of XFile objects using the listofFiles variable
                  //     }
                  //   },
                  //   child: DropTarget(
                  //     onDragDone: (detail) {
                  //       setState(() {
                  //         listofFiles.addAll(detail.files);
                  //       });
                  //     },
                  //     onDragEntered: (detail) {
                  //       setState(() {
                  //         dragging = true;
                  //       });
                  //     },
                  //     onDragExited: (detail) {
                  //       setState(() {
                  //         dragging = false;
                  //       });
                  //     },
                  //     child: Container(
                  //       child: listofFiles.isEmpty
                  //           ? Center(child: Icon(Icons.attach_file, size: 25, color: Colors.blue.shade900))
                  //           : Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           // Icon(Icons.attach_file, size: 25),
                  //           // SizedBox(height: 10),
                  //           Text(listofFiles.map((file) => file.name).join("\n")),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
    //*************************************************************************

                  // LayoutBuilder(
                  //   builder: (context, constraints) {
                  //     return IconButton(
                  //       onPressed: openGallery,
                  //       icon: Icon(
                  //         color: Colors.blue.shade900,
                  //         Icons.photo,
                  //         size: 25,
                  //       ),
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 46.0),
                  // if (galleryImage != null)
                  //   Image.memory(
                  //     galleryImage!,
                  //     height: 250,
                  //     width: 250,
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

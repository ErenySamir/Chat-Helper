import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageID> _list = [];
  final _textController = TextEditingController();
  bool _showEmoji = false;
  bool _isUploading = false;
  final player = AudioPlayer();
  late ZegoExpressEngine _zegoEngine;

  @override
  void initState() {
    super.initState();
    initializeZegoEngine();
  }

  @override
  void dispose() {
    super.dispose();
    destroyZegoEngine();
  }

  void initializeZegoEngine() async {
    // Initialize the ZegoExpressEngine SDK
    await ZegoExpressEngine.createEngine(appID, appSign, isTestEnv, scenario);

    // Create a ZegoExpressEngine instance
    _zegoEngine = ZegoExpressEngine.getInstance();

    // Configure ZegoExpressEngine settings, such as audio and video settings

    // Login to the ZegoExpressEngine with user information
    _zegoEngine.loginRoom(roomID, userID, userName);

    // Start audio/video communication

    // Set up listeners for receiving audio/video streams and other events
  }

  void destroyZegoEngine() {
    // Stop audio/video communication

    // Logout from the ZegoExpressEngine
    _zegoEngine.logoutRoom(roomID);

    // Destroy the ZegoExpressEngine instance
    ZegoExpressEngine.destroyEngine();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: _appBar(),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _list.length,
                    padding: EdgeInsets.only(top: mq.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MessageCard(message: _list[index]);
                    },
                  ),
                ),
                if (_isUploading)
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                _chatInput(),
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
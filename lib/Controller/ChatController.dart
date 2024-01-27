import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Pages/Call/Calls.dart';

class ChatController extends GetxController {
  int currentIndex = 0;
  void navigateToCallPage() {
    Get.to(() => CallPage(callID: "user_two"));
  }
}
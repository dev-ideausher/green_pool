import 'package:get/get.dart';

import '../controllers/chat_with_experts_controller.dart';

class ChatWithExpertsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatWithExpertsController>(
      () => ChatWithExpertsController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/push_notifications_controller.dart';

class PushNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PushNotificationsController>(
      () => PushNotificationsController(),
    );
  }
}

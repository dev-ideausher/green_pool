import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'network_controller.dart';

class DependencyInjection {
  static Future<void> init() async {
    Get.put<NetworkController>(NetworkController(), permanent: true);


  }
}

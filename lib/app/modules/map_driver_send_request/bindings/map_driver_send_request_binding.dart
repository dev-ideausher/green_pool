import 'package:get/get.dart';

import '../controllers/map_driver_send_request_controller.dart';

class MapDriverSendRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapDriverSendRequestController>(
      () => MapDriverSendRequestController(),
    );
  }
}

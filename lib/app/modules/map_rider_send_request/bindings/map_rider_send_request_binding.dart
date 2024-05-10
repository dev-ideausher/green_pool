import 'package:get/get.dart';

import '../controllers/map_rider_send_request_controller.dart';

class MapRiderSendRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapRiderSendRequestController>(
      () => MapRiderSendRequestController(),
    );
  }
}

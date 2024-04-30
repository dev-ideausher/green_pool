import 'package:get/get.dart';

import '../controllers/map_driver_confirm_request_controller.dart';

class MapDriverConfirmRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapDriverConfirmRequestController>(
      () => MapDriverConfirmRequestController(),
    );
  }
}

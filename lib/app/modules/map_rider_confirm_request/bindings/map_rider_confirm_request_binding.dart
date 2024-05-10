import 'package:get/get.dart';

import '../controllers/map_rider_confirm_request_controller.dart';

class MapRiderConfirmRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapRiderConfirmRequestController>(
      () => MapRiderConfirmRequestController(),
    );
  }
}

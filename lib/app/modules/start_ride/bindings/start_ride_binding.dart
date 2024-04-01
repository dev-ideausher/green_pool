import 'package:get/get.dart';

import '../controllers/start_ride_controller.dart';

class StartRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartRideController>(
      () => StartRideController(),
    );
  }
}

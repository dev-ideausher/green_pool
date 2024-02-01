import 'package:get/get.dart';

import '../controllers/rider_post_ride_controller.dart';

class RiderPostRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderPostRideController>(
      () => RiderPostRideController(),
    );
  }
}

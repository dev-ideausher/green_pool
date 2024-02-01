import 'package:get/get.dart';

import '../controllers/rider_my_rides_controller.dart';

class RiderMyRidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderMyRidesController>(
      () => RiderMyRidesController(),
    );
  }
}

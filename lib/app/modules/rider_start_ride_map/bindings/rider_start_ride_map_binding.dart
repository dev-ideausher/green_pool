import 'package:get/get.dart';

import '../controllers/rider_start_ride_map_controller.dart';

class RiderStartRideMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderStartRideMapController>(
      () => RiderStartRideMapController(),
    );
  }
}

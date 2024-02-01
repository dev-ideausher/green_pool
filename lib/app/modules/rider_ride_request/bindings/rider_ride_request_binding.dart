import 'package:get/get.dart';

import '../controllers/rider_ride_request_controller.dart';

class RiderRideRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderRideRequestController>(
      () => RiderRideRequestController(),
    );
  }
}

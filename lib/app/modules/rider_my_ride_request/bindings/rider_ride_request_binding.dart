import 'package:get/get.dart';

import '../controllers/rider_my_ride_request_controller.dart';

class RiderMyRideRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderMyRideRequestController>(
      () => RiderMyRideRequestController(),
    );
  }
}

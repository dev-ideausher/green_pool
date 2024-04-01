import 'package:get/get.dart';

import '../controllers/rider_confirmed_ride_details_controller.dart';

class RiderConfirmedRideDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderConfirmedRideDetailsController>(
      () => RiderConfirmedRideDetailsController(),
    );
  }
}

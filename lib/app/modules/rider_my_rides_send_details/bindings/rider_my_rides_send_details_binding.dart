import 'package:get/get.dart';

import '../controllers/rider_my_rides_send_details_controller.dart';

class RiderMyRidesSendDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderMyRidesSendDetailsController>(
      () => RiderMyRidesSendDetailsController(),
    );
  }
}

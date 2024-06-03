import 'package:get/get.dart';

import '../../map_rider_send_request/controllers/map_rider_send_request_controller.dart';
import '../controllers/rider_my_ride_request_controller.dart';

class RiderMyRideRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderMyRideRequestController>(
      () => RiderMyRideRequestController(),
    );
    Get.lazyPut<MapRiderSendRequestController>(
          () => MapRiderSendRequestController(),
    );

  }
}

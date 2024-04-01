import 'package:get/get.dart';

import '../controllers/rider_my_rides_confirm_details_controller.dart';

class RiderMyRidesConfirmDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderMyRidesConfirmDetailsController>(
      () => RiderMyRidesConfirmDetailsController(),
    );
  }
}

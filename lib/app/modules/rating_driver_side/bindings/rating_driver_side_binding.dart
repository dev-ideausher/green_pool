import 'package:get/get.dart';

import '../controllers/rating_driver_side_controller.dart';

class RatingDriverSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingDriverSideController>(
      () => RatingDriverSideController(),
    );
  }
}

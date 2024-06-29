import 'package:get/get.dart';

import '../controllers/rating_rider_side_controller.dart';

class RatingRiderSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RatingRiderSideController>(() => RatingRiderSideController(),
        fenix: true);
  }
}

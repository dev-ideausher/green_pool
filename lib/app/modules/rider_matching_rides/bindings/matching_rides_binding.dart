import 'package:get/get.dart';

import '../controllers/matching_rides_controller.dart';

class MatchingRidesBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<MatchingRidesController>(
    //   () => MatchingRidesController(),
    // );
    Get.put(MatchingRidesController());
  }
}

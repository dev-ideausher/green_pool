import 'package:get/get.dart';

import '../controllers/rider_filter_controller.dart';

class RiderFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderFilterController>(
      () => RiderFilterController(),
    );
  }
}

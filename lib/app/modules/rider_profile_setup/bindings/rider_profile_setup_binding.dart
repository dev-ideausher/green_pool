import 'package:get/get.dart';

import '../controllers/rider_profile_setup_controller.dart';

class RiderProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiderProfileSetupController>(
      () => RiderProfileSetupController(),
    );
  }
}

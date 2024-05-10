import 'package:get/get.dart';

import '../controllers/vehicle_setup_controller.dart';

class VehicleSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleSetupController>(
      () => VehicleSetupController(),
    );
  }
}

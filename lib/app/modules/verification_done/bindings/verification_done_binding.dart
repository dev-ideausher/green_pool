import 'package:get/get.dart';

import '../controllers/verification_done_controller.dart';

class VerificationDoneBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<VerificationDoneController>(
    //   () => VerificationDoneController(),
    // );
    Get.put(VerificationDoneController());
  }
}

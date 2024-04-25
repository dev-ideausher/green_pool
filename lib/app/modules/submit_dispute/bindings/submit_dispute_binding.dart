import 'package:get/get.dart';

import '../controllers/submit_dispute_controller.dart';

class SubmitDisputeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitDisputeController>(
      () => SubmitDisputeController(),
    );
  }
}

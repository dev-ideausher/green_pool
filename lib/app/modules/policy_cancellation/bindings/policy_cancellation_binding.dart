import 'package:get/get.dart';

import '../controllers/policy_cancellation_controller.dart';

class PolicyCancellationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyCancellationController>(
      () => PolicyCancellationController(),
    );
  }
}

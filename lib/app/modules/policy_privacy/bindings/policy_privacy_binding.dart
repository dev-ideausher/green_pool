import 'package:get/get.dart';

import '../controllers/policy_privacy_controller.dart';

class PolicyPrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolicyPrivacyController>(
      () => PolicyPrivacyController(),
    );
  }
}

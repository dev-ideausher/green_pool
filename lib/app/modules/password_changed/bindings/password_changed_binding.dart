import 'package:get/get.dart';

import '../controllers/password_changed_controller.dart';

class PasswordChangedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordChangedController>(
      () => PasswordChangedController(),
    );
  }
}

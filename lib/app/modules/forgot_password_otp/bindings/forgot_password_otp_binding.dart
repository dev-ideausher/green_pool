import 'package:get/get.dart';

import '../controllers/forgot_password_otp_controller.dart';

class ForgotPasswordOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordOtpController>(
      () => ForgotPasswordOtpController(),
    );
  }
}

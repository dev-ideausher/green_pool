import 'package:get/get.dart';

import '../controllers/pay_now_controller.dart';

class PayNowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PayNowController>(PayNowController());
  }
}

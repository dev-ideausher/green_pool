import 'package:get/get.dart';

import '../controllers/web_add_pay_controller.dart';

class WebAddPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAddPayController>(
      () => WebAddPayController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/web_add_to_bank_controller.dart';

class WebAddToBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebAddToBankController());
  }
}

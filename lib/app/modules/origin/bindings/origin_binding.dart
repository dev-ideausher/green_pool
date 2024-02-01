import 'package:get/get.dart';

import '../controllers/origin_controller.dart';

class OriginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OriginController>(
      () => OriginController(),
    );
  }
}

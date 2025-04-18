import 'package:get/get.dart';

import '../controllers/prev_posted_controller.dart';

class PrevPostedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrevPostedController>(
      () => PrevPostedController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/post_ride_step_one_controller.dart';

class PostRideStepOneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRideStepOneController>(
      () => PostRideStepOneController(),
    );
  }
}

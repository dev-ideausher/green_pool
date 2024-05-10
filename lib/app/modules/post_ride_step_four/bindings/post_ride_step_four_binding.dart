import 'package:get/get.dart';

import '../controllers/post_ride_step_four_controller.dart';

class PostRideStepFourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRideStepFourController>(
      () => PostRideStepFourController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/post_ride_step_two_controller.dart';

class PostRideStepTwoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRideStepTwoController>(
      () => PostRideStepTwoController(),
    );
  }
}

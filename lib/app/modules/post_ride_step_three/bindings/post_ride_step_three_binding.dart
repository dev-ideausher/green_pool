import 'package:get/get.dart';

import '../controllers/post_ride_step_three_controller.dart';

class PostRideStepThreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRideStepThreeController>(
      () => PostRideStepThreeController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/post_ride_controller.dart';

class PostRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostRideController());
  }
}

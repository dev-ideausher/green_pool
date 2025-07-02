import 'package:get/get.dart';

import '../controllers/ride_invite_screen_controller.dart';

class RideInviteScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideInviteScreenController>(
      () => RideInviteScreenController(),
    );
  }
}

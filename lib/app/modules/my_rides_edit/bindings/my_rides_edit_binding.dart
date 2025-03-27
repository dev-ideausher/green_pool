import 'package:get/get.dart';

import '../controllers/my_rides_edit_controller.dart';

class MyRidesEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesEditController>(
      () => MyRidesEditController(),
    );
  }
}

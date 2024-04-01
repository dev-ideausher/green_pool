import 'package:get/get.dart';

import '../controllers/my_rides_page_controller.dart';

class MyRidesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesPageController>(
      () => MyRidesPageController(),
    );
  }
}

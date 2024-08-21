import 'package:get/get.dart';

import '../controllers/my_rides_confirm_details_controller.dart';

class MyRidesConfirmDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesConfirmDetailsController>(
      () => MyRidesConfirmDetailsController(),
    );
  }
}

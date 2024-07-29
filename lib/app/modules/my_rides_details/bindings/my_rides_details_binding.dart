import 'package:get/get.dart';

import '../controllers/my_rides_details_controller.dart';

class MyRidesDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesDetailsController>(
      fenix: true,
      () => MyRidesDetailsController(),
    );
  }
}

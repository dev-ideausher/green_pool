import 'package:get/get.dart';

import '../controllers/my_rides_recurring_details_controller.dart';

class MyRidesRecurringDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesRecurringDetailsController>(
      () => MyRidesRecurringDetailsController(),
    );
  }
}

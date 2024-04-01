import 'package:get/get.dart';

import '../controllers/my_rides_recurring_controller.dart';

class MyRidesRecurringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyRidesRecurringController>(
      () => MyRidesRecurringController(),
    );
  }
}

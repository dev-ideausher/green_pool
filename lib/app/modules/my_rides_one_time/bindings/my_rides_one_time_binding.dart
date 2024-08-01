import 'package:get/get.dart';

import '../controllers/my_rides_one_time_controller.dart';

class MyRidesOneTImeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(() => MyRidesOneTimeController());
    Get.lazyPut<MyRidesOneTimeController>(
      fenix: true,
      () => MyRidesOneTimeController(),
    );
  }
}

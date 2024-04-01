import 'package:get/get.dart';

import '../controllers/my_rides_controller.dart';

class MyRidesOneTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => MyRidesOneTimeController());
  }
}

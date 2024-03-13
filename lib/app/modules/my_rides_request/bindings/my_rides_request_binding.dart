import 'package:get/get.dart';

import '../controllers/my_rides_request_controller.dart';

class MyRidesRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => MyRidesRequestController());
  }
}

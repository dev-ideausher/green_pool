import 'package:get/get.dart';

import '../controllers/previous_rides_controller.dart';

class PreviousRidesBinding extends Bindings {
  @override
  void dependencies() {    
    Get.put(PreviousRidesController());
  }
}

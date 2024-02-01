import 'package:get/get.dart';

import '../controllers/add_stops_controller.dart';

class AddStopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStopsController>(
      () => AddStopsController(),
    );
  }
}

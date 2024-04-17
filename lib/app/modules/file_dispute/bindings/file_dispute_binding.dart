import 'package:get/get.dart';

import '../controllers/file_dispute_controller.dart';

class FileDisputeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FileDisputeController());
  }
}

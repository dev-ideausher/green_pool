import 'package:get/get.dart';

import '../controllers/student_discounts_controller.dart';

class StudentDiscountsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDiscountsController>(
      () => StudentDiscountsController(),
    );
  }
}

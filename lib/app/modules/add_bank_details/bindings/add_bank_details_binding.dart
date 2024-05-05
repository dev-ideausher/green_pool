import 'package:get/get.dart';

import '../controllers/add_bank_details_controller.dart';

class AddBankDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankDetailsController>(
      () => AddBankDetailsController(),
    );
  }
}

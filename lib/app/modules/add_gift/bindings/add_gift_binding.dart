import 'package:get/get.dart';

import '../controllers/add_gift_controller.dart';

class AddGiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddGiftBinding>(
      () => AddGiftBinding(),
    );
  }
}

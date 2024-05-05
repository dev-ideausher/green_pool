import 'package:get/get.dart';

import '../controllers/wallet_to_bank_acc_controller.dart';

class WalletToBankAccBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletToBankAccController>(
      () => WalletToBankAccController(),
    );
  }
}

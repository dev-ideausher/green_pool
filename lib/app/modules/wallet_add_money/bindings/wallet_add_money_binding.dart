import 'package:get/get.dart';

import '../controllers/wallet_add_money_controller.dart';

class WalletAddMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletAddMoneyController>(
      () => WalletAddMoneyController(),
    );
  }
}

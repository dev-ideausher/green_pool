import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../routes/app_pages.dart';

class WalletController extends GetxController {
  final RxBool isLoad = true.obs;
  final RxString walletBalance = "0.0".obs;
  final RxString stripeAccountId = "".obs;
  final RxBool hasCompletedOnboarding = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getWallet();
    isLoad.value = false;
  }

  getWallet() async {
    try {
      final res = await APIManager.walletBalance();
      walletBalance.value = res.data['wallet'] ?? 0;
      walletBalance.refresh();
      stripeAccountId.value = res.data['stripeAccountId'] ?? "";
      stripeAccountId.refresh();
      hasCompletedOnboarding.value =
          res.data['hasCompletedOnboarding'] ?? false;
      hasCompletedOnboarding.refresh();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  history() {
    Get.toNamed(Routes.TRANSACTION_HISTORY);
  }

  addMoney() {
    Get.toNamed(Routes.WALLET_ADD_MONEY);
  }

  sendMoney() {
    Get.toNamed(Routes.WALLET_TO_BANK_ACC);
  }
}

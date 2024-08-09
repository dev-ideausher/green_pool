import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class WebAddToBankController extends GetxController {
  String amount = "";
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    amount = Get.arguments;
  }

  Future<void> transferToBankAccount(String stripeAccCode) async {
    try {
      isLoading.value = true;
      final response = await APIManager.postAuthorizeStripeToken(
          body: {"code": stripeAccCode});
      if (response.data["status"]) {
        try {
          final res = await APIManager.postTransferAmountToWallet(
              body: {"amount": amount});
          if (res.data["status"]) {
            Get.find<WalletController>().getWallet();
            Get.until(
              (route) => Get.currentRoute == Routes.WALLET,
            );
          } else {
            Get.until(
              (route) => Get.currentRoute == Routes.WALLET,
            );
            showMySnackbar(msg: res.data["message"].toString());
          }
        } catch (e) {
          isLoading.value = false;
          Get.until(
            (route) => Get.currentRoute == Routes.WALLET,
          );
          debugPrint("ERROR: $e");
        }
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.until(
        (route) => Get.currentRoute == Routes.WALLET,
      );
      debugPrint("ERROR: $e");
    }
  }

  /*@override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }*/
}

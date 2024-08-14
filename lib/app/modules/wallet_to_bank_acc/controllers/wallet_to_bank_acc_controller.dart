import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../wallet/controllers/wallet_controller.dart';

class WalletToBankAccController extends GetxController {
  TextEditingController amountTextController = TextEditingController();
  RxBool buttonState = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String? fareValidator(String input) {
    // Check if input is empty
    if (input.isEmpty) {
      return "Fare cannot be empty";
    }

    // Check if input can be parsed to an integer
    try {
      int fare = int.parse(input);

      // Check if fare is between 5 and 500
      if (fare >= 5 && fare <= 500) {
        return null;
      } else {
        return "Fare must be between 5 and 500";
      }
    } catch (e) {
      return "Invalid input. Please enter a valid integer fare";
    }
  }

  setButtonState(String value) {
    if (value.isEmpty ||
        value == "" ||
        int.parse(value) < 5 ||
        int.parse(value) > 500) {
      buttonState.value = false;
    } else {
      buttonState.value = true;
    }
  }

  moveToWebToBankAcc() {
    //refresh user info from home controller
    final code =
        Get.find<HomeController>().userInfo?.value?.data?.connectedAccountId;

    if (code == "") {
      Get.toNamed(Routes.WEB_ADD_TO_BANK,
          arguments: amountTextController.value.text);
    } else {
      transferToBankAccount();
    }
  }

  Future<void> transferToBankAccount() async {
    try {
      final res = await APIManager.postTransferAmountToWallet(
          body: {"amount": amountTextController.value.text});
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
      Get.until(
        (route) => Get.currentRoute == Routes.WALLET,
      );
      debugPrint("ERROR: $e");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dialog_helper.dart';

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

      if (fare >= 25) {
        return null;
      } else {
        return "Fare must be greater than 25";
      }
    } catch (e) {
      return "Invalid input. Please enter a valid integer fare";
    }
  }

  setButtonState(String value) {
    final walletBalance =
        double.parse(Get.find<WalletController>().walletBalance.value);
    if (value.isEmpty ||
        value == "" ||
        int.parse(value) < 25 ||
        walletBalance <= 0.0 ||
        int.parse(value) > walletBalance) {
      buttonState.value = false;
    } else {
      buttonState.value = true;
    }
  }

  moveToWebToBankAcc() async {
    final hasCompletedOnboarding =
        Get.find<WalletController>().hasCompletedOnboarding.value;

    if (!hasCompletedOnboarding) {
      await getStripeRedirectLink();
    } else {
      transferToBankAccount();
    }
  }

  Future<void> getStripeRedirectLink() async {
    try {
      DialogHelper.showLoading();
      final response = await APIManager.putCreateStripeAccount();
      if (response.data['status']) {
        print("STRIPE LINK: ${response.data['data']['link']['url']}");
        DialogHelper.hideDialog();
        Get.toNamed(Routes.WEB_ADD_TO_BANK,
                arguments: response.data['data']['link']['url'])
            ?.then(
          (value) async {
            try {
              DialogHelper.showLoading();
              Get.find<WalletController>().getWallet();
              await Future.delayed(const Duration(seconds: 2));
              final hasCompletedOnboarding =
                  Get.find<WalletController>().hasCompletedOnboarding.value;
              if (hasCompletedOnboarding) {
                transferToBankAccount();
              }
              DialogHelper.hideDialog();
            } catch (e) {
              DialogHelper.hideDialog();
              debugPrint(e.toString());
            }
          },
        );
      } else {
        print("STRIPE LINK: ${response.data['data']['url']}");
        DialogHelper.hideDialog();
        Get.toNamed(Routes.WEB_ADD_TO_BANK,
                arguments: response.data['data']['url'])
            ?.then(
          (value) async {
            try {
              DialogHelper.showLoading();
              Get.find<WalletController>().getWallet();

              await Future.delayed(const Duration(seconds: 2));
              final hasCompletedOnboarding =
                  Get.find<WalletController>().hasCompletedOnboarding.value;
              if (hasCompletedOnboarding) {
                transferToBankAccount();
              }
              DialogHelper.hideDialog();
            } catch (e) {
              DialogHelper.hideDialog();
              debugPrint(e.toString());
            }
          },
        );
      }
    } catch (e) {
      showMySnackbar(msg: Strings.somethingWentWrong);
      debugPrint("ERROR: $e");
    } finally {
      DialogHelper.hideDialog();
    }
  }

  Future<void> transferToBankAccount() async {
    try {
      final res = await APIManager.postTransferWalletBalance(
          body: {"amount": double.parse(amountTextController.text.trim())});
      if (res.data["status"]) {
        showMySnackbar(msg: Strings.moneyHasBeenTransferred);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/wallet/controllers/wallet_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/add_amount_model.dart';

class WalletAddMoneyController extends GetxController {
  TextEditingController amountTextController = TextEditingController();
  RxBool buttonState = false.obs;

  @override
  void onInit() {
    super.onInit();
  }



  setButtonState(String value) {
    if (value.isEmpty || value == "" || int.parse(value) < 100 ) {
      buttonState.value = false;
    } else {
      buttonState.value = true;
    }
  }

  addMoney() async {
    // Get.toNamed(Routes.PAYMENT_METHOD);
    try {
      final response = await APIManager.addAmount(body: {"amount": amountTextController.text.trim()});
      final addAmountModel = AddAmountModel.fromJson(response.data);
      if (addAmountModel.status ?? false) {
        amountTextController.clear();
        Get.toNamed(Routes.WEB_ADD_PAY, arguments: addAmountModel.data)?.then((value) => Get.find<WalletController>().getWallet());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

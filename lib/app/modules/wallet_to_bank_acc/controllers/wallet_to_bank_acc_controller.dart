import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';

import '../../verify/controllers/verify_controller.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = "+1";
  bool isDriver = false;
  RxBool isActive = false.obs;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments;
  }

  checkLogin() async {
    final isValid = loginKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      loginKey.currentState!.save();
      await otpAuth();
    }
  }

  otpAuth() async {
    try {
      print("phone number: ${phoneNumberController.text}");
      await Get.find<AuthService>()
          .mobileOtp(phoneno: countryCode + phoneNumberController.text);

      await Get.offNamed(
        Routes.VERIFY,
        arguments: {
          'isDriver': isDriver,
          'phoneNumber': phoneNumberController.value.text
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      isActive.value = true;
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  void googleAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      await Get.find<AuthService>().google();
      await Get.find<VerifyController>().loginAPI();
    } catch (error) {
      log("$error");
    }
  }
}

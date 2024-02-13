// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/verify/controllers/verify_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';

class CreateAccountController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isChecked = false.obs;
  bool isDriver = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String countryCode = "+1";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    isDriver = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  setVisible() {
    isVisible.toggle();
  }

  checkValidation() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
      await otpAuth();
    }
  }

  String? nameValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Check if the value contains only letters (and optionally spaces)
    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null; // Return null if the value is valid
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  otpAuth() async {
    try {
      print("phone number: ${phoneNumberController.text}");
      if (isChecked.value == true) {
        await Get.find<AuthService>()
            .mobileOtp(phoneno: countryCode + phoneNumberController.text);

        await Get.offNamed(Routes.VERIFY,
            // arguments: CreateAccData(
            //     fullName: fullNameController.text,
            //     isDriver: isDriver,
            //     phoneNumber: phoneNumberController.text),
            arguments: isDriver);
      } else {
        showMySnackbar(msg: 'Terms and Conditions not accepted');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  void googleAuth() async {
    Get.lazyPut(() => VerifyController());
    try {
      await Get.find<AuthService>().google();
      await Get.find<VerifyController>().loginAPI();
    } catch (error) {
      log("$error");
    }
  }
}

// onboardingAPI() async {
//   try {
//     await APIManager.getLogin();
//   } on Exception catch (e) {
//     log(e.toString());
//   }
// }

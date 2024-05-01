import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';

import '../../verify/controllers/verify_controller.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isVisible = false.obs;
  String countryCode = "+1";
  bool isDriver = false;
  bool fromNavBar = false;
  RxBool isActive = false.obs;
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments['isDriver'];
    fromNavBar = Get.arguments['fromNavBar'];
  }

  setVisible() {
    isVisible.toggle();
  }

  String? passwordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Check if the password meets the criteria (e.g., length, complexity)
    // For example, let's enforce a minimum length of 8 characters and at least one uppercase letter, one lowercase letter, one digit, and one special character.
    final RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    final RegExp digitRegExp = RegExp(r'[0-9]');
    final RegExp specialCharacterRegExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!upperCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!lowerCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!digitRegExp.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!specialCharacterRegExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Return null if the value is valid
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
      log("phone number: ${phoneNumberController.text}");
      await Get.find<AuthService>()
          .mobileOtp(phoneno: countryCode + phoneNumberController.text);

      await Get.offNamed(
        Routes.VERIFY,
        arguments: {
          'isDriver': isDriver,
          'phoneNumber': countryCode + " " + phoneNumberController.value.text,
          'fromNavBar': fromNavBar
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

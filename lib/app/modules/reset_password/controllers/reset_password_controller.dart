import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';

class ResetPasswordController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isVisibleTwo = false.obs;
  TextEditingController passwordControllerOne = TextEditingController();
  TextEditingController passwordControllerTwo = TextEditingController();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  setVisible() {
    isVisible.toggle();
  }

  setVisibleTwo() {
    isVisibleTwo.toggle();
  }

  checkPassword() async {
    final isValid = passwordFormKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      passwordFormKey.currentState!.save();
      showMySnackbar(msg: 'Password changed');
      Get.offNamed(Routes.PASSWORD_CHANGED);
    }
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

  String? confirmPasswordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    // Check if the confirmed password matches the original password
    if (value != passwordControllerOne.value.text) {
      return 'Passwords do not match';
    }

    return null; // Return null if the value is valid
  }
}

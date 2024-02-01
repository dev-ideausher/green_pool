// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/create_acc_data.dart';
import 'package:green_pool/app/modules/verify/views/verification_done.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';

class CreateAccountController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isChecked = false.obs;
  bool isDriver = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

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

  nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
  }

  otpAuth() async {
    try {
      print("phone number: ${phoneNumberController.text}");
      if (isChecked.value == true) {
        await Get.find<AuthService>()
            .mobileOtp(phoneno: countryCode + phoneNumberController.text);

        await Get.toNamed(
          Routes.VERIFY,
          arguments: CreateAccData(
              fullName: fullNameController.text,
              isDriver: isDriver,
              phoneNumber: phoneNumberController.text),
        );
      } else {
        showMySnackbar(msg: 'Terms and Conditions not accepted');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  googleAuth() async {
    try {
      if (await Get.find<AuthService>().google()) {
        Get.to(() => const VerificationDone());
        Map<String, dynamic> userData = {
          'fullName': "${_firebaseAuth.currentUser?.displayName}",
          'phone': " ${_firebaseAuth.currentUser?.phoneNumber}",
          'email': "  ${_firebaseAuth.currentUser?.email}",
          'isTermsAccepted': true,
        };
        await onboardingAPI(userData: userData);
      } else {
        print("Status = false");
      }
    } catch (e) {
      print('$e');
    }
  }

  onboardingAPI({required Map<String, dynamic> userData}) async {
    try {
      await APIManager.postRegister(body: userData);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

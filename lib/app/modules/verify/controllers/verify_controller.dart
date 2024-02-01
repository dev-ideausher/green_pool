// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/login/controllers/login_controller.dart';
import 'package:green_pool/app/modules/verify/views/verification_done.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../../../data/create_acc_data.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';

class VerifyController extends GetxController {
  final otpController = TextEditingController();
  CreateAccData createAccData = CreateAccData();
  final auth = FirebaseAuthenticationService();

  @override
  void onInit() {
    super.onInit();
    createAccData.phoneNumber = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  verifyOTP() async {
    try {
      bool isStatus = await Get.find<AuthService>()
          .verifyMobileOtp(otp: otpController.text);
      if (isStatus) {
        // Map<String, dynamic> userData = {
        //   'fullName': createAccData.fullName,
        //   'isTermsAccepted':
        //       Get.find<CreateAccountController>().isChecked.value,
        // };

        // await registerAPI(userData: userData);
        await Get.find<LoginController>().loginAPI();
      } else {
        showMySnackbar(msg: "error saving user data");
      }
    } catch (e) {
      print('otp error: $e');
    }
  }

  registerAPI({required Map<String, dynamic> userData}) async {
    try {
      final response = await APIManager.postRegister(body: userData);
      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE BODY: ${response.data}');

      if (response.data['status']) {
        Get.to(() => const VerificationDone(),
            arguments: createAccData.isDriver);
      } else {
        showMySnackbar(msg: response.data['message']);
        print('REGISTRATION FAILED');
      }
    } catch (e) {
      log(" ERROR: $e");
    }
  }
}

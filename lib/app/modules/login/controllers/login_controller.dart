import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/user_info_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/carpool_schedule_view.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  String countryCode = "+1";
  bool isDriver = false;

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

  otpAuth() async {
    try {
      print("phone number: ${phoneNumberController.text}");
      await Get.find<AuthService>()
          .mobileOtp(phoneno: countryCode + phoneNumberController.text);

      await Get.toNamed(
        Routes.VERIFY,
        arguments: phoneNumberController.text,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  loginAPI() async {
    try {
      final response = await APIManager.getLogin();
      final userInfo = UserInfoModel.fromJson(response.data);

      if (userInfo.status!) {
        Get.find<GetStorageService>().setLoggedIn = true;

        if (isDriver) {
          // Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);

          //? the original flow
          Get.off(() => const CarpoolScheduleView(), arguments: isDriver);
        } else {
          Get.offNamed(Routes.MATCHING_RIDES);
        }

        Get.find<GetStorageService>().setDriver = isDriver;
      } else {
        Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);
      }
    } catch (e) {
      log("error: $e");
    }
  }
}

googleAuth() async {
  if (await Get.find<AuthService>().google()) {
    await onboardingAPI();
    if (Get.find<HomeController>().findingRide.value) {
      Get.toNamed(Routes.MATCHING_RIDES);
    } else {
      Get.to(() => const CarpoolScheduleView());
    }
    Get.offAll(() => const CarpoolScheduleView());
  }
}

onboardingAPI() async {
  try {
    await APIManager.getLogin();
    // await APIManager.getUserByID();
  } on Exception catch (e) {
    log(e.toString());
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/push_notification_service.dart';
import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool pinkMode = Get.find<HomeController>().isPinkModeOn;
  var userInfo = Get.find<HomeController>().userInfo;
  TextEditingController ratingTextController = TextEditingController();
  RxDouble rating = 4.0.obs;
  RxString profilePic = "".obs;
  RxString fullName = "".obs;

  @override
  void onInit() {
    super.onInit();
    updateInfo();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void toggleSwitch() {
    pinkMode.value = !pinkMode.value;
    Get.find<GetStorageService>().isPinkMode = pinkMode.value;
    pinkModeAPI();
  }

  pinkModeAPI() async {
    try {
      final response = await APIManager.enablePinkMode();
      if (response.data["status"]) {
        log(response.data.toString());
      } else {
        showMySnackbar(msg: response.data["message"].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toLogin() {
    Get.toNamed(Routes.LOGIN,
            arguments: {'isDriver': false, 'fromNavBar': true})
        ?.then((value) => userInfo.refresh());
  }

  Future<void> submitFeedback() async {
    try {
      final response = await APIManager.postRateApplication(body: {
        "rating": rating.value,
        "review": ratingTextController.value.text
      });
      if (response.statusMessage == "OK") {
        Get.back();
        showMySnackbar(msg: Strings.thankyouForRatingTheApp);
        ratingTextController.clear();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logoutUser() {
    Get.find<AuthService>().logOutUser();
    pinkMode.value = false;
    PushNotificationService.unsubFcm("${userInfo.value.data?.Id}");
    Get.find<HomeController>().changeTabIndex(0);
    Get.find<HomeController>().userInfo.value.data?.emergencyContactDetails =
        [];
    Get.offAllNamed(Routes.ONBOARDING);
  }

  void updateInfo() {
    profilePic.value = Get.find<GetStorageService>().profilePicUrl ?? "";
    fullName.value = Get.find<GetStorageService>().getUserName ?? "";
  }
}

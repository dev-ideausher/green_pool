import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool pinkMode = Get.find<HomeController>().isPinkModeOn;
  var userInfo = Get.find<HomeController>().userInfo;
  TextEditingController ratingTextController = TextEditingController();
  RxDouble rating = 4.0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

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
      var data = jsonDecode(response.toString());
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
        showMySnackbar(
            msg:
                "Thank you for rating our app! Your feedback helps us improve and serve you better.");
      } else {
        showMySnackbar(msg: response.data['message'].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

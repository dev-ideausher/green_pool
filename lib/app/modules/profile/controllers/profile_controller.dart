import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool pinkMode = Get.find<HomeController>().isPinkModeOn;
  var userInfo = Get.find<HomeController>().userInfo;

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
      log(data.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toLogin() {
    Get.toNamed(Routes.LOGIN,
            arguments: {'isDriver': false, 'fromNavBar': true})
        ?.then((value) => userInfo.refresh());
  }
}

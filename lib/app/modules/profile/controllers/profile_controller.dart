import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool isSwitched = false.obs;
  var userInfo = Get.find<HomeController>().userInfo;
  // RxBool isSwitched = Get.find<GetStorageService>().isPinkMode;

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

  bool toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    Get.find<GetStorageService>().isPinkMode = isSwitched.value;
    return isSwitched.value;
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
}

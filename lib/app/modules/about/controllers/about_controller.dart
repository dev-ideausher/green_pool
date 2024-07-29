import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

class AboutController extends GetxController {
  RxBool isLoading = false.obs;
  String aboutText = "";

  @override
  void onInit() {
    super.onInit();
    aboutUsAPI();
  }

  aboutUsAPI() async {
    try {
      isLoading.value = true;
      final res = await APIManager.aboutUs();
      if (res.data["status"]) {
        aboutText = res.data["data"]["about"];
      } else {
        showMySnackbar(msg: res.data["message"]);
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

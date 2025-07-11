import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (Get.currentRoute == Routes.SPLASH) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 1), () => decideRouting());
      });
    }
  }

  decideRouting() {
    if (Get.find<GetStorageService>().isLoggedIn) {
      Get.offNamed(Routes.BOTTOM_NAVIGATION);
    } else {
      Get.offNamed(Routes.ONBOARDING);
    }
  }

  @override
  void onReady() {
    super.onReady();
    // This is called after build is complete

    ever(Get.routing.obs, (routing) {
      if (routing.current == Routes.SPLASH && routing.previous != null) {
        decideRouting();
      }
    });
  }

}

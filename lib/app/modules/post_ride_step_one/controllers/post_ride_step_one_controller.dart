import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';

class PostRideStepOneController extends GetxController {
  TextEditingController originTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  TextEditingController stop1TextController = TextEditingController();
  TextEditingController stop2TextController = TextEditingController();
  RxBool isActive = false.obs;
  RxBool isStop1Added = false.obs;
  final RxBool isDriver = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDriver.value = Get.arguments;
  }

  setActiveStatePostRideView() {
    if (originTextController.value.text.isNotEmpty && destinationTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  decideRouting() {
    // Decides if the user is logged in and redirects accordingly
    if (Get.find<GetStorageService>().getLoggedIn) {
      if (isDriver.value) {
        showMySnackbar(msg: 'Please fill in vehicle details');
        Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);
      } else {
        Get.toNamed(Routes.CARPOOL_SCHEDULE, arguments: isDriver);
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }
}

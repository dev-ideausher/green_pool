import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides/controllers/my_rides_controller.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController? pageController = PageController();
  final RxBool findingRide = false.obs;

  RxBool isPink = Get.find<ProfileController>().isSwitched.value.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => MyRidesController());
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

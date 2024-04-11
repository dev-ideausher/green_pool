import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/my_rides_model.dart';
import '../../../services/dio/api_service.dart';

class RatingDriverSideController extends GetxController {
  final Rx<MyRidesModelData> myRidesModel = MyRidesModelData().obs;
  double? rating;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
  }

  rateUserAPI(String Id) async {
    final Map<String, dynamic> data = {"ratedTo": Id, "rating": rating};

    try {
      await APIManager.postRateUsers(
        body: data,
      );
      showMySnackbar(msg: "Thankyou for rating!");
      Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      debugPrint(e.toString());
    }
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/my_rides_model.dart';
import '../../../services/dio/api_service.dart';
import '../../home/controllers/home_controller.dart';

class RatingDriverSideController extends GetxController {
  final Rx<BookingDetailModelData> myRidesModel = BookingDetailModelData().obs;
  RxDouble rating =4.5.obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
  }

  rateUserAPI(String Id) async {
    final Map<String, dynamic> data = {"ratedTo": Id, "rating": rating.value};

    try {
      final res = await APIManager.postRateUsers(body: data);
      if (res.data['status']) {
        showMySnackbar(msg: "Thankyou for rating!");
        Get.find<HomeController>().changeTabIndex(0);
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        showMySnackbar(msg: res.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

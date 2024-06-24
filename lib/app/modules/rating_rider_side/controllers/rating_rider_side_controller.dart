import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../data/booking_detail_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';

class RatingRiderSideController extends GetxController {
  String rideId = "";
  final Rx<BookingDetailModel> myRidesModel = BookingDetailModel().obs;
  Map<String, dynamic> msgData = {};
  int numberOfRiders = 3;
  RxDouble rating = 4.5.obs;
  RxDouble driverRating = 4.5.obs;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    msgData = Get.arguments;
    rideId = msgData['rideId'].toString();
    await myRidesDetailsAPI(rideId);
    print(msgData['rideId'].toString());
    //66694d4196469f3dfb3c67c5
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      isLoading.value = true;
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      var data = jsonDecode(response.toString());
      // myRidesModel.value = BookingDetailModel.fromJson(data).data!;
      myRidesModel.value = BookingDetailModel.fromJson(data);
      print(myRidesModel.value.data?.driverBookingDetails?.destination?.name);
      isLoading.value = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  rateDriverAPI(String driverId) async {
    final Map<String, dynamic> data = {
      "ratedTo": driverId, //65c228fd32f497dc57fdeff8
      "rating": driverRating.value //4.0
    };

    try {
      final res = await APIManager.postRateUsers(body: data);
      if (res.data['status']) {
        showMySnackbar(msg: "Thankyou for rating!");
        Get.find<HomeController>().changeTabIndex(0);
        // Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        showMySnackbar(msg: res.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  rateUserAPI(String Id) async {
    final Map<String, dynamic> data = {"ratedTo": Id, "rating": rating.value};

    try {
      final res = await APIManager.postRateUsers(body: data);
      if (res.data['status']) {
        showMySnackbar(msg: "Thankyou for rating!");
      } else {
        showMySnackbar(msg: res.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../data/booking_detail_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';

class RatingRiderSideController extends GetxController {
  String rideId = "";
  final Rx<BookingDetailModelData> bookingModelData =
      BookingDetailModelData().obs;
  Map<String, dynamic> msgData = {};
  // int numberOfRiders = 3;
  RxDouble rating = 4.0.obs;
  RxDouble driverRating = 4.0.obs;
  final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
  RxBool isLoading = true.obs;
  var ratingList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() async {
    super.onInit();
    msgData = Get.arguments;
    rideId = msgData['rideId'].toString();
    await myRidesDetailsAPI(rideId);
    print("RIDE ID FOR RATING: ${msgData['rideId'].toString()}");
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      if (response.data["status"]) {
        final mData = BookingDetailModel.fromJson(response.data);
        bookingModelData.value = mData.data!;
        bookingModelData.value.driverBookingDetails?.riderBookingDetails = mData
            .data!.driverBookingDetails!.riderBookingDetails!
            .where((element) => (element.riderDetails?.Id !=
                Get.find<GetStorageService>().getUserAppId))
            .toList();
      } else {
        Get.back();
        showMySnackbar(msg: response.data["message"].toString());
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void addRating(String id, double userRating) {
    ratingList.add({"ratedTo": id, "rating": userRating});
  }

  Future<void> rateUserAPI() async {
    final Map<String, dynamic> data = {"userRating": ratingList.value};
    print("DATA: ${data.toString()}");

    try {
      final res = await APIManager.postRateUsers(body: data);
      if (res.data['status']) {
        showMySnackbar(msg: "Thank you for rating!");
        Get.find<HomeController>().changeTabIndex(0);
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
      } else {
        showMySnackbar(msg: res.data['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dialog_helper.dart';

import '../../../data/request_ride_by_rider_model.dart';
import '../../../data/rider_confirm_request_model.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../rider_my_ride_request/views/request_accepted_bottom.dart';

class PaymentController extends GetxController {
  Map<String, dynamic> rideData = {};
  var requestRideModel = RequestRideByRiderModel().obs;
  var riderSendRequestModelData = RiderSendRequestModelData();
  var riderConfirmRequestModelData = RiderConfirmRequestModelData();
  final RxInt walletBalance = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool fromDriverDetails = false.obs;
  final RxBool fromConfirmRequestSection = false.obs;
  String ridePostId = "";
  String price = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      rideData = Get.arguments['rideData'];
      riderSendRequestModelData = Get.arguments['riderSendRequestModelData'];
      await getWallet();
    } catch (e) {
      try {
        ridePostId = Get.arguments['ridePostId'];
        price = Get.arguments['price'];
        riderConfirmRequestModelData =
            Get.arguments['riderConfirmRequestModelData'];
        fromConfirmRequestSection.value = true;
        await getWallet();
      } catch (e) {
        rideData = Get.arguments;
        fromDriverDetails.value = true;
        await getWallet();
      }
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

  getWallet() async {
    try {
      final res = await APIManager.walletBalance();
      walletBalance.value = res.data['wallet']['balance'] ?? 0;
      walletBalance.refresh();
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void decideAPI() {
    if (fromDriverDetails.value) {
      createRideAlert();
    } else if (fromConfirmRequestSection.value) {
      confirmRequestOfDriverAPI();
    } else {
      sendRequesttoDriverAPI();
    }
  }

  createRideAlert() async {
    try {
      final response = await APIManager.postCreateAlert(body: rideData);
      requestRideModel.value = RequestRideByRiderModel.fromJson(response.data);
      if (requestRideModel.value.status ?? false) {
        DialogHelper.paymentSuccessfull();
      } else {
        showMySnackbar(msg: requestRideModel.value.message ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendRequesttoDriverAPI() async {
    try {
      final response = await APIManager.postSendRequestToDriver(body: rideData);
      if (response.data['status']) {
        DialogHelper.paymentSuccessfull();
        Get.find<MyRidesOneTimeController>().myRidesAPI();
        Get.find<RiderMyRideRequestController>().allRiderSendRequestAPI();
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> confirmRequestOfDriverAPI() async {
    try {
      final response = await APIManager.acceptDriversRequest(
          body: {"ridePostId": ridePostId, "price": price});
      if (response.data['status']) {
        Get.bottomSheet(const RequestAcceptedBottom());
        Get.find<RiderMyRideRequestController>().allRiderConfirmRequestAPI();
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

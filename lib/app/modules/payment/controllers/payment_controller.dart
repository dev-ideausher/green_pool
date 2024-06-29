import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/promo_code_model.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/services/dialog_helper.dart';

import '../../../data/request_ride_by_rider_model.dart';
import '../../../data/rider_confirm_request_model.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../rider_my_ride_request/views/request_accepted_bottom.dart';
import '../views/insufficient_balance_bottomsheet.dart';

class PaymentController extends GetxController {
  Map<String, dynamic> rideData = {};
  var requestRideModel = RequestRideByRiderModel().obs;
  var riderSendRequestModelData = RiderSendRequestModelData();
  var riderConfirmRequestModelData = RiderConfirmRequestModelData();
  var promoCodeModel = PromoCodeModel().obs;
  final RxInt walletBalance = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isPromoLoading = true.obs;
  final RxBool discountAvailed = false.obs;
  final RxBool buttonState = false.obs;
  final RxBool fromDriverDetails = false.obs;
  final RxBool fromConfirmRequestSection = false.obs;
  String ridePostId = "";
  int price = 0;
  int discountProvided = 0;
  int totalAmount = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      rideData = Get.arguments['rideData'];
      riderSendRequestModelData = Get.arguments['riderSendRequestModelData'];
      price = rideData['price'];
      totalAmount = rideData['price'];
      await getWallet();
    } catch (e) {
      try {
        ridePostId = Get.arguments['ridePostId'];
        price = int.parse(Get.arguments['price']);
        totalAmount = int.parse(Get.arguments['price']);
        riderConfirmRequestModelData =
            Get.arguments['riderConfirmRequestModelData'];
        fromConfirmRequestSection.value = true;
        await getWallet();
      } catch (e) {
        rideData = Get.arguments;
        fromDriverDetails.value = true;
        price = rideData['ridesDetails']['price'];
        totalAmount = rideData['ridesDetails']['price'];
        await getWallet();
      }
    }
    checkWalletBalance();
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
    rideData!['ridesDetails']!['price'] = totalAmount;
    print("CHECK PRICE: ${rideData['ridesDetails'].toString()}");

    try {
      final response = await APIManager.postCreateAlert(body: {
        "ridesDetails": rideData['ridesDetails'],
        "driverRideId": rideData['driverRideId'],
        "distance": rideData['distance']
      });
      requestRideModel.value = RequestRideByRiderModel.fromJson(response.data);
      if (requestRideModel.value.status ?? false) {
        DialogHelper.paymentSuccessfull();
      } else {
        // showMySnackbar(msg: response.data['message'].toString() ?? "");
        Get.bottomSheet(const InsufficientBalanceSheet());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendRequesttoDriverAPI() async {
    try {
      final response = await APIManager.postSendRequestToDriver(body: {
        "riderRideId": rideData['riderRideId'],
        "driverRideId": rideData['driverRideId'],
        "driverId": rideData['driverId'],
        "driverName": rideData['driverName'],
        "driverNotificationPreferences":
            rideData['driverNotificationPreferences'],
        "price": totalAmount,
      });
      if (response.data['status']) {
        DialogHelper.paymentSuccessfull();
        Get.find<MyRidesOneTimeController>().myRidesAPI();
        Get.find<RiderMyRideRequestController>().allRiderSendRequestAPI();
      } else {
        // showMySnackbar(msg: response.data['message']);
        Get.bottomSheet(const InsufficientBalanceSheet());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> confirmRequestOfDriverAPI() async {
    try {
      final response = await APIManager.acceptDriversRequest(
          body: {"ridePostId": ridePostId, "price": totalAmount});
      if (response.data['status']) {
        Get.bottomSheet(const RequestAcceptedBottom());
        Get.find<RiderMyRideRequestController>().allRiderConfirmRequestAPI();
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      } else {
        // showMySnackbar(msg: response.data['message']);
        Get.bottomSheet(const InsufficientBalanceSheet());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  promoCodeAPI() async {
    try {
      isPromoLoading.value = true;
      final response = await APIManager.getPromoCode();
      var data = jsonDecode(response.toString());
      promoCodeModel.value = PromoCodeModel.fromJson(data);
      isPromoLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  applyDiscount(index) {
    isLoading.value = true;
    if (price >= promoCodeModel.value.data![index]!.minAmount!.toInt()) {
      //if price meets minAmnt criteria then apply type of discount accordingly
      discountAvailed.value = true;
      if (promoCodeModel.value.data![index]!.discountCodeType == "%") {
        final int discountPercent =
            promoCodeModel.value.data![index]!.discountAmount!;

        final int discountAmount = (price * discountPercent / 100).round();

        discountProvided = discountAmount;

        final int discountedPrice = price - discountAmount;

        totalAmount = discountedPrice;
      } else {
        final int? discount = promoCodeModel.value.data![index]!.discountAmount;
        discountProvided = discount!;
        totalAmount = price - discount;
      }
      isLoading.value = false;
      Get.back();
    } else {
      //if price does not meet minAmnt criteria
      isLoading.value = false;
      showMySnackbar(
          msg:
              "The minimum ride amount to avail this offer is \$${promoCodeModel.value.data![index]!.minAmount!}");
    }
  }

  void checkWalletBalance() {
    if (walletBalance.value >= price) {
      buttonState.value = true;
    } else {
      buttonState.value = false;
    }
  }
}

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
  final RxDouble walletBalance = 0.0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isPromoLoading = true.obs;
  final RxBool discountAvailed = false.obs;
  final RxBool buttonState = false.obs;
  final RxBool fromDriverDetails = false.obs;
  final RxBool fromConfirmRequestSection = false.obs;
  String ridePostId = "";
  String promoCodeId = "";
  int price = 0;
  double discountProvided = 0.0;
  double totalAmount = 0.0;
  int pricePerSeat = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      rideData = Get.arguments['rideData'];
      riderSendRequestModelData = Get.arguments['riderSendRequestModelData'];
      price = rideData['price'];
      totalAmount = double.parse(rideData['price'].toStringAsFixed(2));
      pricePerSeat = int.parse(Get.arguments['pricePerSeat']);
    } catch (e) {
      try {
        ridePostId = Get.arguments['ridePostId'];
        price = int.parse(Get.arguments['price']);
        totalAmount =
            double.parse(int.parse(Get.arguments['price']).toStringAsFixed(2));
        riderConfirmRequestModelData =
            Get.arguments['riderConfirmRequestModelData'];
        pricePerSeat = Get.arguments['pricePerSeat'];
        fromConfirmRequestSection.value = true;
      } catch (e) {
        rideData = Get.arguments["rideData"];
        fromDriverDetails.value = true;
        price = rideData['ridesDetails']["price"];
        totalAmount =
            double.parse(rideData['ridesDetails']["price"].toStringAsFixed(2));
        pricePerSeat = Get.arguments["pricePerSeat"];
      }
    }
    checkWalletBalance();
    await getWallet();
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
    rideData!['ridesDetails']!['price'] = price;

    if (walletBalance.value >= totalAmount) {
      try {
        final response = await APIManager.postCreateAlert(body: {
          "ridesDetails": rideData['ridesDetails'],
          "driverRideId": rideData['driverRideId'],
          "distance": rideData['distance'],
          "promoCodeId": promoCodeId
        });
        requestRideModel.value =
            RequestRideByRiderModel.fromJson(response.data);
        if (requestRideModel.value.status ?? false) {
          DialogHelper.paymentSuccessfull();
        } else {
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Get.bottomSheet(const InsufficientBalanceSheet());
    }
  }

  Future<void> sendRequesttoDriverAPI() async {
    if (walletBalance.value >= totalAmount) {
      try {
        final response = await APIManager.postSendRequestToDriver(body: {
          "riderRideId": rideData['riderRideId'],
          "driverRideId": rideData['driverRideId'],
          "driverId": rideData['driverId'],
          "driverName": rideData['driverName'],
          "driverNotificationPreferences":
              rideData['driverNotificationPreferences'],
          "price": price,
          "promoCodeId": promoCodeId
        });
        if (response.data['status']) {
          DialogHelper.paymentSuccessfull();
          Get.find<MyRidesOneTimeController>().myRidesAPI();
          Get.find<RiderMyRideRequestController>().allRiderSendRequestAPI();
        } else {
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Get.bottomSheet(const InsufficientBalanceSheet());
    }
  }

  Future<void> confirmRequestOfDriverAPI() async {
    if (walletBalance.value >= totalAmount) {
      try {
        final response = await APIManager.acceptDriversRequest(body: {
          "ridePostId": ridePostId,
          "price": price,
          "promoCodeId": promoCodeId
        });
        if (response.data['status']) {
          Get.bottomSheet(const RequestAcceptedBottom());
          Get.find<RiderMyRideRequestController>().allRiderConfirmRequestAPI();
          Get.find<MyRidesOneTimeController>().myRidesAPI();
        } else {
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Get.bottomSheet(const InsufficientBalanceSheet());
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
        final double discountPercent =
            promoCodeModel.value.data![index]!.discountAmount!;

        final double discountAmount =
            double.parse((price * discountPercent / 100).toStringAsFixed(2));

        discountProvided = discountAmount;

        final double discountedPrice = price - discountAmount;

        totalAmount = discountedPrice;
      } else {
        final double? discount =
            promoCodeModel.value.data![index]!.discountAmount;
        discountProvided = discount!;
        totalAmount = price - discount;
      }
      promoCodeId = promoCodeModel.value.data?[index]?.Id ?? "";
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

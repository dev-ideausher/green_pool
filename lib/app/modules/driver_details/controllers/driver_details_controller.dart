import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/data/matching_rides_model.dart';
import 'package:green_pool/app/data/request_ride_by_rider_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

class DriverDetailsController extends GetxController {
  var matchingRidesModelData = MatchingRidesModelData().obs;
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';

  var requestRideModel = RequestRideByRiderModel().obs;

  @override
  void onInit() {
    super.onInit();
    rideDetails = Get.arguments['rideDetails'];
    rideDetails!['ridesDetails']!['price'] = Get.arguments["price"];
    driverRideId = Get.arguments['driverRideId'];
    matchingRidesModelData.value = Get.arguments['matchingRidesmodel'];
    minStopDistance = Get.arguments['distance'];
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  moveToPayment() {
    final Map<String, dynamic> rideData = {
      "ridesDetails": rideDetails!["ridesDetails"],
      "driverRideId": driverRideId,
      "distance": minStopDistance,
    };
    Get.toNamed(Routes.PAYMENT, arguments: rideData);
  }

  Future<void> chatWithDriver() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId:
              matchingRidesModelData.value.driverDetails?.first?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              id: matchingRidesModelData.value.driverDetails?.first?.Id,
              name: matchingRidesModelData.value.driverDetails?.first?.fullName,
              image: matchingRidesModelData
                  .value.driverDetails?.first?.profilePic?.url));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

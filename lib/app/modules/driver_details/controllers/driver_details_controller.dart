import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/data/matching_rides_model.dart';
import 'package:green_pool/app/data/request_ride_by_rider_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import '../../../services/dio/api_service.dart';

class DriverDetailsController extends GetxController {
  var matchingRidesModelData = MatchingRidesModelData().obs;
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';
  int pricePerSeat = 0;

  var requestRideModel = RequestRideByRiderModel().obs;

  @override
  void onInit() {
    super.onInit();
    pricePerSeat = Get.arguments['pricePerSeat'];
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
    rideDetails?["ridesDetails"]["date"] =
        matchingRidesModelData.value.time.toString().split("T").first;
    rideDetails?["ridesDetails"]["time"] = matchingRidesModelData.value.time;
    if (rideDetails?["ridesDetails"]["origin"]["name"] == "") {
      rideDetails?["ridesDetails"]["origin"]["name"] =
          matchingRidesModelData.value.matchedOriginLocation?.name;
      rideDetails?["ridesDetails"]["origin"]["longitude"] =
          matchingRidesModelData
              .value.matchedOriginLocation?.coordinates?.first;
      rideDetails?["ridesDetails"]["origin"]["latitude"] =
          matchingRidesModelData.value.matchedOriginLocation?.coordinates?.last;
    }
    if (rideDetails?["ridesDetails"]["destination"]["name"] == "") {
      rideDetails?["ridesDetails"]["destination"]["name"] =
          matchingRidesModelData.value.matchedDestinationLocation?.name;
      rideDetails?["ridesDetails"]["destination"]["longitude"] =
          matchingRidesModelData
              .value.matchedDestinationLocation?.coordinates?.first;
      rideDetails?["ridesDetails"]["destination"]["latitude"] =
          matchingRidesModelData
              .value.matchedDestinationLocation?.coordinates?.last;
    }

    final Map<String, dynamic> rideData = {
      "ridesDetails": rideDetails!["ridesDetails"],
      "driverRideId": driverRideId,
      "distance": minStopDistance,
    };
    Get.toNamed(Routes.PAYMENT,
        arguments: {"rideData": rideData, "pricePerSeat": pricePerSeat});
  }

  Future<void> chatWithDriver() async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId:
              matchingRidesModelData.value.driverDetails?.first?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: matchingRidesModelData.value.driverDetails?.first?.Id,
              name: matchingRidesModelData.value.driverDetails?.first?.fullName,
              image: matchingRidesModelData
                  .value.driverDetails?.first?.profilePic?.url));
    } catch (e) {
      try {
        Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
                chatRoomId: "",
                id: matchingRidesModelData.value.driverDetails?.first?.Id,
                name:
                    matchingRidesModelData.value.driverDetails?.first?.fullName,
                image: matchingRidesModelData
                    .value.driverDetails?.first?.profilePic?.url));
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}

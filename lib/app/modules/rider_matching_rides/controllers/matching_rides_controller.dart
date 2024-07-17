import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../find_ride/controllers/find_ride_controller.dart';
import '../views/create_ride_alert_bottomsheet.dart';

class MatchingRidesController extends GetxController {
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';

  // String minStopDistance = '';
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  Rx<MatchingRidesModel> matchingRidesModel = MatchingRidesModel().obs;
  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    rideDetails = Get.arguments;
    await getMatchingRidesAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> getMatchingRidesAPI() async {
    final findRideData = rideDetails;

    try {
      final response = await APIManager.postFindMatchingDrivers(
          body: findRideData, queryParam: "?isFindRide=true");
      matchingRidesModel.value =
          MatchingRidesModel.fromJson(jsonDecode(response.toString()));
      matchingRidesModel.refresh();
      isLoading.value = false;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  moveToFilter() {
    Get.toNamed(Routes.RIDER_FILTER, arguments: {
      'rideDetails': rideDetails,
      'matchingRidesModel': matchingRidesModel.value
    })?.then((value) {
      matchingRidesModel.value = value;
      matchingRidesModel.refresh();
    });
  }

  Future<void> moveToDriverDetails(index) async {
    driverRideId = "${matchingRidesModel.value.data?[index]?.Id}";
    // minStopDistance =
    //     "${matchingRidesModel.value.data?[index]?.minStopDistance}";

    final distance = await GpUtil.calculateDistanceInInt(
        startLat:
            matchingRidesModel.value.data?[index]?.origin?.coordinates?.last ??
                latitude,
        startLong:
            matchingRidesModel.value.data?[index]?.origin?.coordinates?.first ??
                longitude,
        endLat: matchingRidesModel
                .value.data?[index]?.destination?.coordinates?.last ??
            latitude,
        endLong: matchingRidesModel
                .value.data?[index]?.destination?.coordinates?.first ??
            longitude);
    final price =
        int.parse(matchingRidesModel.value.data?[index]?.price ?? "0") *
            (rideDetails?['ridesDetails']['seatAvailable']);
    final pricePerSeat =
        int.parse(matchingRidesModel.value.data?[index]?.price ?? "0");
    Get.toNamed(Routes.DRIVER_DETAILS, arguments: {
      'rideDetails': rideDetails,
      'driverRideId': driverRideId,
      "price": price,
      "pricePerSeat": pricePerSeat,
      'distance': distance.toString(),
      'matchingRidesmodel': matchingRidesModel.value.data?[index]
    });
  }

  Future<void> createRideAlert() async {
    if (rideDetails?['ridesDetails']['date'] != "" &&
        rideDetails?['ridesDetails']['time'] != "" &&
        rideDetails?['ridesDetails']['origin']['name'] != "" &&
        rideDetails?['ridesDetails']['destination']['name'] != "") {
      try {
        final res = await Get.find<FindRideController>().riderPostRideAPI();

        await Get.bottomSheet(
          isDismissible: false,
          persistent: true,
          const CreateRideAlertBottomsheet(),
        );
        await getMatchingRidesAPI();
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Get.back();
      showMySnackbar(
          msg: "To create a ride alert please enter all the details");
    }
  }
}

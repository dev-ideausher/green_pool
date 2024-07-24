import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/rider_matching_rides/views/filter_ride.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../data/find_ride_response_model.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../views/create_ride_alert_bottomsheet.dart';

class MatchingRidesController extends GetxController {
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';

  // String minStopDistance = '';
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  Rx<MatchingRidesModel> matchingRidesModel = MatchingRidesModel().obs;
  RxBool isLoading = true.obs;
  var rideresponse = FindRideResponseModel().obs;

  //filter
  RxBool earlyDeparture = false.obs;
  RxBool lowestPrice = false.obs;
  RxBool closeToDeparture = false.obs;
  RxBool closeToArrival = false.obs;
  RxBool appreciatesConvo = false.obs;
  RxBool enjoysMusic = false.obs;
  RxBool smokeFree = false.obs;
  RxBool petFriendly = false.obs;
  RxBool winterTires = false.obs;
  RxBool coolOrHeat = false.obs;
  RxBool babySeat = false.obs;
  RxBool heatedSeats = false.obs;
  bool preferenceAdded = false;
  bool sortByAdded = false;

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
      if (matchingRidesModel.value.status!) {
        matchingRidesModel.refresh();
        isLoading.value = false;
      } else {
        showMySnackbar(msg: matchingRidesModel.value.message ?? "");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  moveToFilter() {
    Get.to(() => const FilterRide());
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
        riderPostRideAPI();
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Get.back();
      showMySnackbar(
          msg: "To create a ride alert please enter all the details");
    }
  }

  Future<void> riderPostRideAPI() async {
    final findRideData = rideDetails;

    try {
      final response = await APIManager.postRiderFindRide(body: findRideData);
      if (response.data['status']) {
        rideresponse.value =
            FindRideResponseModel.fromJson(jsonDecode(response.toString()));
        await Get.bottomSheet(
          isDismissible: false,
          persistent: true,
          const CreateRideAlertBottomsheet(),
        );
        await getMatchingRidesAPI();
        log("this is rider's ride id: ${rideresponse.value.data![0]?.Id}");
      } else {
        showMySnackbar(msg: response.data['message'].toString() ?? "");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //filter
  clearAll() {
    earlyDeparture.value = false;
    lowestPrice.value = false;
    closeToDeparture.value = false;
    closeToArrival.value = false;
    appreciatesConvo.value = false;
    enjoysMusic.value = false;
    smokeFree.value = false;
    petFriendly.value = false;
    winterTires.value = false;
    coolOrHeat.value = false;
    babySeat.value = false;
    heatedSeats.value = false;
  }

  filterRideAPI() async {
    String queryParam = "";

    Map<String, dynamic> getPreferencesData() {
      final Map<String, dynamic> preferencesData = {};

      if (appreciatesConvo.value)
        preferencesData["AppreciatesConversation"] = true;
      if (enjoysMusic.value) preferencesData["EnjoysMusic"] = true;
      if (coolOrHeat.value) preferencesData["CoolingOrHeating"] = true;
      if (smokeFree.value) preferencesData["SmokeFree"] = true;
      if (petFriendly.value) preferencesData["PetFriendly"] = true;
      if (winterTires.value) preferencesData["WinterTires"] = true;
      if (babySeat.value) preferencesData["BabySeats"] = true;
      if (heatedSeats.value) preferencesData["HeatedSeats"] = true;

      return preferencesData;
    }

    Map<String, dynamic> getSortByFilters() {
      final Map<String, dynamic> sortType = {};

      if (closeToArrival.value) sortType["sortByCloseToArrival"] = true;
      if (closeToDeparture.value) sortType["sortByCloseToDeparture"] = true;
      if (earlyDeparture.value) sortType["sortByDeparture"] = true;
      if (lowestPrice.value) sortType["sortByPrice"] = true;

      return sortType;
    }

    String sortTypeJson = jsonEncode(getSortByFilters());
    String preferencesDataJson = jsonEncode(getPreferencesData());

    if (appreciatesConvo.value == true ||
        enjoysMusic.value == true ||
        smokeFree.value == true ||
        petFriendly.value == true ||
        winterTires.value == true ||
        coolOrHeat.value == true ||
        babySeat.value == true ||
        heatedSeats.value == true) {
      preferenceAdded = true;
    } else {
      preferenceAdded = false;
    }

    if (closeToArrival.value ||
        closeToDeparture.value ||
        earlyDeparture.value ||
        lowestPrice.value) {
      sortByAdded = true;
    } else {
      sortByAdded = false;
    }

    if (sortByAdded && preferenceAdded) {
      queryParam =
          "?sortType=${sortTypeJson}&preferences=${preferencesDataJson}&isFindRide=true";
    } else if (sortByAdded) {
      queryParam = "?sortType=${sortTypeJson}&isFindRide=true";
    } else if (preferenceAdded) {
      queryParam = "?preferences=${preferencesDataJson}&isFindRide=true";
    } else {
      queryParam = "?isFindRide=true";
    }

    try {
      isLoading.value = true;
      Get.back();
      final response = await APIManager.postFindMatchingDrivers(
          body: rideDetails, queryParam: queryParam);
      var data = jsonDecode(response.toString());
      matchingRidesModel.value = MatchingRidesModel.fromJson(data);
      matchingRidesModel.refresh();
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }
}

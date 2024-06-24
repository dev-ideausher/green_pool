import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/matching_rides_model.dart';

class RiderFilterController extends GetxController {
  Map<String, dynamic>? rideDetails;
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
  var matchingRidesModel = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    rideDetails = Get.arguments['rideDetails'];
    matchingRidesModel.value = Get.arguments['matchingRidesModel'];
  }

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
          "?sortType=${sortTypeJson}&preferences=${preferencesDataJson}";
    } else if (sortByAdded) {
      queryParam = "?sortType=${sortTypeJson}";
    } else {
      queryParam = "?preferences=${preferencesDataJson}";
    }

    try {
      final response = await APIManager.postMatchngRides(
          body: rideDetails, queryParam: queryParam);
      var data = jsonDecode(response.toString());
      matchingRidesModel.value = MatchingRidesModel.fromJson(data);
      Get.back(result: matchingRidesModel.value);
    } catch (e) {
      throw Exception(e);
    }
  }
}

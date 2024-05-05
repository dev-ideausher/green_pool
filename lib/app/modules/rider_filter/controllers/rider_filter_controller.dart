import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../data/matching_rides_model.dart';

class RiderFilterController extends GetxController {
  Map<String, dynamic>? rideDetails;
  RxBool earlyDeparture = false.obs;
  RxBool lowestPrice = false.obs;
  RxBool closeToDeparture = false.obs;
  RxBool closeToarrival = false.obs;
  RxBool appreciatesConvo = false.obs;
  RxBool enjoysMusic = false.obs;
  RxBool smokeFree = false.obs;
  RxBool petFriendly = false.obs;
  RxBool winterTires = false.obs;
  RxBool coolOrHeat = false.obs;
  RxBool babySeat = false.obs;
  RxBool heatedSeats = false.obs;
  bool preferenceAdded = false;
  var matchingRideResponse = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    rideDetails = Get.arguments['rideDetails'];
    matchingRideResponse.value = Get.arguments['matchingRidesModel'];
  }

  clearAll() {
    earlyDeparture.value = false;
    lowestPrice.value = false;
    closeToDeparture.value = false;
    closeToarrival.value = false;
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
    var preferencesData = {
      "AppreciatesConversation": appreciatesConvo.value,
      "EnjoysMusic": enjoysMusic.value,
      "CoolingOrHeating": coolOrHeat.value,
      "SmokeFree": smokeFree.value,
      "PetFriendly": petFriendly.value,
      "WinterTires": winterTires.value,
      "BabySeats": babySeat.value,
      "HeatedSeats": heatedSeats.value
    };
    final Map<String, dynamic> preferences = {
      "sortByCloseToDeparture": closeToDeparture.value,
      "preferences": jsonEncode(preferencesData)
    };

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

    if (closeToarrival.value == true) {
      if (closeToDeparture.value == true) {
        if (preferenceAdded) {
          queryParam = preferences.toString() +
              "&sortBycloseToArrival=${closeToarrival.value}&sortByCloseToDeparture=${closeToDeparture.value}";
        } else {
          queryParam =
              "sortBycloseToArrival=${closeToarrival.value}&sortByCloseToDeparture=${closeToDeparture.value}";
        }
      } else {
        if (preferenceAdded) {
          queryParam = preferences.toString() +
              "&sortBycloseToArrival=${closeToarrival.value}";
        } else {
          queryParam = "sortBycloseToArrival=${closeToarrival.value}";
        }
      }
    } else if (closeToDeparture.value == true) {
      if (closeToarrival.value == true) {
        if (preferenceAdded) {
          queryParam = preferences.toString() +
              "&sortBycloseToArrival=${closeToarrival.value}&sortByCloseToDeparture=${closeToDeparture.value}";
        } else {
          queryParam =
              "sortBycloseToArrival=${closeToarrival.value}&sortByCloseToDeparture=${closeToDeparture.value}";
        }
      } else {
        if (preferenceAdded) {
          queryParam = preferences.toString() +
              "&sortByCloseToDeparture=${closeToDeparture.value}";
        } else {
          queryParam = "sortByCloseToDeparture=${closeToDeparture.value}";
        }
      }
    } else {
      if (preferenceAdded) {
        queryParam = preferences.toString();
      } else {
        queryParam = "";
      }
    }

    try {
      final response = await APIManager.postMatchngRides(
          body: rideDetails, queryParam: preferences);
      var data = jsonDecode(response.toString());
      matchingRideResponse.value = MatchingRidesModel.fromJson(data);
      Get.back(result: matchingRideResponse.value);
      log("filter resp data: ${data.toString()}");
    } catch (e) {
      throw Exception(e);
    }
  }
}

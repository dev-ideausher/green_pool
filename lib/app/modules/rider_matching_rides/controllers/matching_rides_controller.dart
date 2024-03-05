import 'dart:convert';
import 'package:get/get.dart';

import '../../../data/matching_rides_model.dart';
import '../../../services/dio/api_service.dart';

class MatchingRidesController extends GetxController {
  String riderRideId = '';
  String driverRideId = '';
  String minStopDistance = '';
  var matchingRideResponse = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    riderRideId = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    matchingRidesAPI();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  matchingRidesAPI() async {
    try {
      final response = await APIManager.getMatchingRides(rideId: riderRideId);
      var data = jsonDecode(response.toString());
      matchingRideResponse.value = MatchingRidesModel.fromJson(data);
      

      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }
}

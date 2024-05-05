import 'dart:convert';

import 'package:get/get.dart';
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

  confirmRideAPI() async {
    final Map<String, dynamic> rideData = {
      "ridesDetails": rideDetails!["ridesDetails"],
      "driverRideId": driverRideId,
      "distance": minStopDistance,
    };
    try {
      final response = await APIManager.postConfirmRide(body: rideData);
      var data = jsonDecode(response.toString());
      requestRideModel.value = RequestRideByRiderModel.fromJson(data);
      showMySnackbar(msg: "Ride request sent successfully!");
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);

      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }
}

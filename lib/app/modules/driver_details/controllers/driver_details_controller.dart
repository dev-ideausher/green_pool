import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/data/request_ride_by_rider_model.dart';
import 'package:green_pool/app/modules/find_ride/controllers/find_ride_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import '../../../services/dio/api_service.dart';

class DriverDetailsController extends GetxController {
  var matchingRidesmodel =
      Get.find<FindRideController>().matchingRideResponse.value;
  int matchingRideIndex = 0;
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';
  var requestRideModel = RequestRideByRiderModel().obs;

  @override
  void onInit() {
    super.onInit();
    matchingRideIndex = Get.arguments['index'];
    rideDetails = Get.arguments['rideDetails'];
    driverRideId = Get.arguments['driverRideId'];
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
      log(data.toString());
      requestRideModel.value = RequestRideByRiderModel.fromJson(data);
      log("ride $rideDetails");
      log("driver $driverRideId");
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);

      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }
}

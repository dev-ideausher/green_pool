import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/recurring_ride_details_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class MyRidesRecurringDetailsController extends GetxController {
  int numberOfDays = 7;
  String rideId = "";
  var recurringModel = RecurringRideDetailsModel().obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    rideId = Get.arguments;
    await recurringRideDetailsAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  recurringRideDetailsAPI() async {
    try {
      isLoading.value = true;
      final String driverRideId = "/$rideId";
      final response =
          await APIManager.getRecurringRideDetails(rideId: driverRideId);
      var data = jsonDecode(response.toString());
      recurringModel.value = RecurringRideDetailsModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }
}

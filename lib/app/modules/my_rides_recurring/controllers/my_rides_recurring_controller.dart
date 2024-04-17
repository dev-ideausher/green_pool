import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/recurring_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class MyRidesRecurringController extends GetxController {
  RxBool isScheduled = false.obs;
  int itemCount = 3;
  var recurringResp = RecurringRidesModel().obs;
  RxBool isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  allRecurringRidesAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getAllRecurringRides();
      var data = jsonDecode(response.toString());
      recurringResp.value = RecurringRidesModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }
}

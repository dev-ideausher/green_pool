import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/recurring_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class MyRidesRecurringController extends GetxController {
  // RxBool isScheduled = false.obs;
  RxList<RxBool> isScheduled = <RxBool>[].obs;
  int itemCount = 100;
  var recurringResp = RecurringRidesModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    isScheduled.assignAll(List.generate(itemCount, (_) => false.obs));
  }

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

  enableRecurringAPI(input) async {
    final driverRideId = input;
    try {
      isLoading.value = true;
      final response =
          await APIManager.enableDisableRecurring(driverRIdeId: driverRideId);
      var data = jsonDecode(response.toString());
      await allRecurringRidesAPI();
      isLoading.value = false;
      print(data.toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}

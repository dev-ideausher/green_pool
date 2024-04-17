import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/ride_history_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

class RideHistoryController extends GetxController {
  RxBool isLoading = false.obs;
  var rideHistModel = RideHistoryModel().obs;
  @override
  void onInit() {
    super.onInit();
    rideHistoryAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  rideHistoryAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getRideHistory();
      var data = jsonDecode(response.toString());
      rideHistModel.value = RideHistoryModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/ride_history_model.dart';
import '../../../services/dio/api_service.dart';


class FileDisputeController extends GetxController {
  RxBool isLoading = true.obs;
  var rideHistModel = RideHistoryModel().obs;
  
  TextEditingController bookingTextController = TextEditingController();
  
  

  @override
  Future<void> onInit() async {
    super.onInit();
    await rideHistoryAPI();
  }

  

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

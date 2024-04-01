import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/my_rides_details_model.dart';

import '../../../data/my_rides_model.dart';
import '../../../services/dio/api_service.dart';

class MyRidesDetailsController extends GetxController {
  final Rx<MyRidesDetailsModel> myRideDetailsModel = MyRidesDetailsModel().obs;
  final Rx<MyRidesModelData> myRidesModelData = MyRidesModelData().obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModelData.value = Get.arguments;
    myRidesDetailsAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // myRidesDetailsAPI(origin, destination) async {
  //   log("ride id that is coming from my_rides_one_time: $driverId");
  //   try {
  //     final response = await APIManager.getMyRidesDetails(rideId: driverId);
  //     var data = jsonDecode(response.toString());
  //     print(data.toString());
  //     myRideDetailsModel.value = MyRidesDetailsModel.fromJson(data);
  //     // myRideDetailsModel.value.data = MyRidesDetailsModelData(origin: );
  //     myRideDetailsModel.value.data?[0]?.destination?.name = destination;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  myRidesDetailsAPI() async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: myRidesModelData.value.Id ?? "");
      var data = jsonDecode(response.toString());
      myRideDetailsModel.value = MyRidesDetailsModel.fromJson(data);
      print(myRideDetailsModel.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

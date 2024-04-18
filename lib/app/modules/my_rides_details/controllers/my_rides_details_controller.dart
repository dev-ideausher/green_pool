import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/my_rides_details_model.dart';
import '../../../data/my_rides_model.dart';
import '../../../services/dio/api_service.dart';

class MyRidesDetailsController extends GetxController {
  final Rx<MyRidesDetailsModel> myRidesModelData = MyRidesDetailsModel().obs;
  final RxBool isLoad = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    await myRidesDetailsAPI(Get.arguments);
    isLoad.value = false;
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      var data = jsonDecode(response.toString());
      myRidesModelData.value = MyRidesDetailsModel.fromJson(data);
      print(myRidesModelData.value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

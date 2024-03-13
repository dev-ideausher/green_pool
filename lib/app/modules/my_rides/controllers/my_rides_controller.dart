import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../services/storage.dart';

class MyRidesController extends GetxController {
  RxBool isDriver = Get.find<GetStorageService>().isDriver.obs;

  RxString driverRideId = ''.obs;
  RxString ridePostId = ''.obs;
  var myRidesModel = MyRidesModel().obs;
  var confirmRequestModel = DriverCofirmRequestModel().obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    myRidesApi();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  myRidesApi() async {
    try {
      final response = await APIManager.getAllMyRides();
      var data = jsonDecode(response.toString());
      myRidesModel.value = MyRidesModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}

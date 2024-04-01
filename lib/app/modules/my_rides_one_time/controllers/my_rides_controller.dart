import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class MyRidesOneTimeController extends GetxController {
  RxBool isDriver = Get.find<GetStorageService>().isDriver.obs;

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

  cancelRideAPI(MyRidesModelData myRidesModelData) async {
    final Map<String, dynamic> rideData = {
      "ridePostId": myRidesModelData.Id,
      "status": {
        'cancelByDriver': true,
      }
    };

    try {
      final cancelRideResponse = await APIManager.postAcceptRiderRequest(body: rideData);
      var data = jsonDecode(cancelRideResponse.toString());
      log("cancel ride api: ${data.toString()}");
    } catch (e) {
      throw Exception(e);
    }
  }

  void viewDetails(MyRidesModelData myRidesModelData) {
    Get.toNamed(Routes.MY_RIDES_DETAILS, arguments: myRidesModelData.Id);
  }
}

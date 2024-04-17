import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../routes/app_pages.dart';

class MyRidesOneTimeController extends GetxController {
  RxString ridePostId = ''.obs;
  final RxList<MyRidesModelData> myRidesModelData = <MyRidesModelData>[].obs;
  var confirmRequestModel = DriverCofirmRequestModel().obs;
  final RxBool isLoad = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  Future<void> onReady() async {
    super.onReady();
    await myRidesAPI();
    isLoad.value = false;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  myRidesAPI() async {
    try {
      isLoad.value = true;
      final response = await APIManager.getAllMyRides();
      var data = jsonDecode(response.toString());
      final mData = MyRidesModel.fromJson(data);
      myRidesModelData.value = mData.data!
          .where((element) => !(element.isCancelled ?? false))
          .toList();
      isLoad.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  riderCancelRideAPI(MyRidesModelData myRidesModelData) async {
    final Map<String, dynamic> riderRideId = {
      "rideRideId": myRidesModelData.Id,
    };
    try {
      isLoad.value = true;
      final cancelRideResponse =
          await APIManager.riderCancelRide(body: riderRideId);
      var data = jsonDecode(cancelRideResponse.toString());
      await myRidesAPI();
      isLoad.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  cancelRideAPI(MyRidesModelData myRidesModelData) async {
    final Map<String, dynamic> driverRideId = {
      "driverRideId": myRidesModelData.Id,
    };
    try {
      isLoad.value = true;
      final cancelRideResponse =
          await APIManager.cancelRide(body: driverRideId);
      var data = jsonDecode(cancelRideResponse.toString());
      await myRidesAPI();
      isLoad.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  void viewDetails(MyRidesModelData myRidesModelData) {
    Get.toNamed(Routes.MY_RIDES_DETAILS, arguments: myRidesModelData);
  }
}

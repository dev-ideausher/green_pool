import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';
import 'package:green_pool/app/data/driver_send_request_model.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/data/my_rides_post_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';

class MyRidesController extends GetxController {
  RxBool mapViewType = false.obs;
  RxBool isDriver = Get.find<GetStorageService>().isDriver.obs;
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  RxString driverRideId = ''.obs;
  var myRidesModel = MyRidesModel().obs;
  var sendRequestModel = DriverSendRequestModel().obs;
  var confirmReuqestModel = DriverCofirmRequestModel().obs;
  Rxn<List<Rider>> testModel = Rxn();

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

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
  }

  myRidesApi() async {
    try {
      final response = await APIManager.getAllMyRides();
      var data = jsonDecode(response.toString());
      myRidesModel.value = MyRidesModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> refreshFunction() {
    return Future.delayed(const Duration(seconds: 2));
  }

  allSendRequestAPI() async {
    try {
      final sendReqResponse = await APIManager.getAllDriverSendRequest(
          driverId: driverRideId.value);
      var data = jsonDecode(sendReqResponse.toString());
      sendRequestModel.value = DriverSendRequestModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  allConfirmRequestAPI() async {
    try {
      // need driver id which will come from confirm ride by rider
      final confirmReqResponse = await APIManager.getAllDriverConfirmRequest(
          driverRideId: driverRideId.value);
      var data = jsonDecode(confirmReqResponse.toString());
      confirmReuqestModel.value = DriverCofirmRequestModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}

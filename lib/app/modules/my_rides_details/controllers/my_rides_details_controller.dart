import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/booking_detail_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class MyRidesDetailsController extends GetxController {
  final Rx<BookingDetailModelData> myRidesModelData =
      BookingDetailModelData().obs;
  final RxBool isLoad = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      myRidesModelData.value = Get.arguments;
    } catch (e) {
      await myRidesDetailsAPI(Get.arguments);
    }
    isLoad.value = false;
  }

  myRidesDetailsAPI(String rideId) async {
    try {
      final response = await APIManager.getMyRidesDetails(rideId: rideId);
      var data = jsonDecode(response.toString());
      myRidesModelData.value = BookingDetailModel.fromJson(data).data!;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void viewMatchingRiders() => Get.toNamed(Routes.MY_RIDES_REQUEST,
      arguments: myRidesModelData.value.driverRideId);

  viewOnMap() =>
      Get.toNamed(Routes.START_RIDE, arguments: myRidesModelData.value);
}

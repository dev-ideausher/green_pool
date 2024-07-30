import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/chat_arg.dart';
import '../../../data/my_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

class RiderConfirmedRideDetailsController extends GetxController {
  final Rx<MyRidesModelData> myRidesModel = MyRidesModelData().obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
    print("ride status " + (myRidesModel.value.isStarted ?? false).toString());
  }

  viewOnMap() {
    Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: myRidesModel.value);
  }

  openMessage(MyRidesModelData data) async {
    try {
      final res = await APIManager.getChatRoomId(receiverId: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.Id,
              name: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName,
              image: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.Id,
              name: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName,
              image: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url));
    }
  }

  riderCancelRideAPI(MyRidesModelData myRidesModelData) async {
    DialogHelper.cancelRideDialog(() async {
      Get.back();
      final Map<String, dynamic> riderRideId = {"riderRideId": myRidesModelData.Id};
      try {
        final cancelRideResponse = await APIManager.riderCancelRide(body: riderRideId);
        if (cancelRideResponse.data["status"]) {
          Get.back();
        } else {
          showMySnackbar(msg: cancelRideResponse.data["message"].toString());
        }
      } catch (e) {
        throw Exception(e);
      }
    });
  }

// @override
// void onReady() {
//   super.onReady();
// }

// @override
// void onClose() {
//   super.onClose();
// }
}

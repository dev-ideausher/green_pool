import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/chat_arg.dart';
import '../../../data/my_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

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
      final res = await APIManager.getChatRoomId(
          receiverId: data.confirmDriverDetails?[0]?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              id: data.confirmDriverDetails?[0]?.Id,
              name: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]
                  ?.driverDetails?[0]?.fullName,
              image: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]
                  ?.driverDetails?[0]?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              id: data.confirmDriverDetails?[0]?.Id,
              name: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]
                  ?.driverDetails?[0]?.fullName,
              image: data.confirmDriverDetails?[0]?.driverPostsDetails?[0]
                  ?.driverDetails?[0]?.profilePic?.url));
      debugPrint(e.toString());
    }
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

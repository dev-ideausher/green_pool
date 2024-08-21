import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/chat_arg.dart';
import '../../../data/driver_cofirm_request_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import '../../my_rides_request/controllers/my_rides_request_controller.dart';
import '../../my_rides_request/views/booking_confirm_bottom.dart';

class MyRidesConfirmDetailsController extends GetxController {
  var riderRideDetails = DriverConfirmRequestModelData();
  RxBool isBtnLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    riderRideDetails = Get.arguments;
  }

  acceptRidersRequestAPI(DriverConfirmRequestModelData? driverRideData) async {
    try {
      final acceptRiderResponse = await APIManager.patchAcceptRiderRequest(
          body: {"ridePostId": driverRideData?.Id ?? ""});

      if (acceptRiderResponse.data['status']) {
        Get.back();
        Get.find<MyRidesRequestController>().allConfirmRequestAPI();
        await Get.bottomSheet(
            BookingConfirmBottom(
              driverRideData: driverRideData,
            ),
            isScrollControlled: true);
        showMySnackbar(msg: 'Request accepted successfully!');
        Get.find<MyRidesOneTimeController>().myRidesAPI();
      } else {
        showMySnackbar(msg: acceptRiderResponse.data?['message'] ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  rejectRidersRequestAPI(DriverConfirmRequestModelData? data) async {
    final String ridePostId = "${data?.Id}";

    final Map<String, dynamic> rideData = {"ridePostId": ridePostId};

    try {
      final rejectRiderResponse =
          await APIManager.patchRejectRiderRequest(body: rideData);
      if (rejectRiderResponse.data['status']) {
        Get.find<MyRidesRequestController>().allConfirmRequestAPI();
        Get.back();
        showMySnackbar(msg: 'Request rejected successfully!');
      } else {
        showMySnackbar(msg: rejectRiderResponse.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  openMessage(DriverConfirmRequestModelDataRideDetails data) async {
    try {
      isBtnLoading.value = true;
      final res = await APIManager.getChatRoomId(
          receiverId: data.riderDetails?.first?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data.riderDetails?.first?.Id,
              name: data.riderDetails?.first?.fullName ?? "",
              image: data.riderDetails?.first?.profilePic?.url));
      isBtnLoading.value = false;
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data.riderDetails?.first?.Id,
              name: data.riderDetails?.first?.fullName ?? "",
              image: data.riderDetails?.first?.profilePic?.url));
      isBtnLoading.value = false;
    }
  }
}

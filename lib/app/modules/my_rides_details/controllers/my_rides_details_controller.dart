import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/booking_detail_model.dart';
import '../../../data/chat_arg.dart';
import '../../../data/ride_detail_id.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../views/bottom_riders.dart';

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
      arguments: RideDetailId(
          driverRidId: myRidesModelData.value.driverRideId ?? "",
          riderRidId: myRidesModelData.value.riderRideId ?? ""));

  viewOnMap() {
    Get.toNamed(Routes.START_RIDE,
        arguments: myRidesModelData.value.driverRideId);
  }

  openMessage() async {
    Get.bottomSheet(BottomRiders(
      riders:
          myRidesModelData.value.driverBookingDetails!.riderBookingDetails ??
              [],
      onPressed: (rider) async {
        try {
          final res =
              await APIManager.getChatRoomId(receiverId: rider.Id ?? "");
          Get.toNamed(Routes.CHAT_PAGE,
              arguments: ChatArg(
                  chatRoomId: res.data["chatChannelId"] ?? "",
                  id: rider.riderDetails?.Id,
                  name: rider.riderDetails?.fullName ?? "",
                  image: rider.riderDetails?.profilePic?.url));
        } catch (e) {
          Get.toNamed(Routes.CHAT_PAGE,
              arguments: ChatArg(
                  id: rider.riderDetails?.Id,
                  name: rider.riderDetails?.fullName,
                  image: rider.riderDetails?.profilePic?.url));
          debugPrint(e.toString());
        }
      },
    ));
  }
}

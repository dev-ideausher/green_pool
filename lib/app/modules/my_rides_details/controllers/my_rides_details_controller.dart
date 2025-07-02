import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../generated/locales.g.dart';
import '../../../data/booking_detail_model.dart';
import '../../../data/chat_arg.dart';
import '../../../data/ride_detail_id.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../utils/date_utils.dart';
import '../views/bottom_riders.dart';

class MyRidesDetailsController extends GetxController {
  final Rx<BookingDetailModelData> myRidesModelData =
      BookingDetailModelData().obs;
  final RxBool isLoad = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final previousRoute = Get.previousRoute;
    debugPrint("PREVIOUS ROUTE: $previousRoute");
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

  viewMatchingRiders() {
    Get.toNamed(Routes.MY_RIDES_REQUEST,
        arguments: RideDetailId(
            driverRidId: myRidesModelData.value.driverRideId ?? "",
            riderRidId: myRidesModelData.value.riderRideId ?? ""));
  }

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
          final res = await APIManager.postChatRoomId(
              receiverId: rider.riderDetails?.Id ?? "",
              body: {
                "driverRideId": myRidesModelData.value.driverRideId,
                "seatsRequired":
                    "", //no need for payment from here hence seatsRequired is empty
                "riderRideId": ""
              });
          Get.toNamed(Routes.CHAT_PAGE,
              arguments: ChatArg(
                  chatRoomId: res.data["data"]["chatRoomId"] ?? "",
                  deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
                  id: rider.riderDetails?.Id,
                  name: rider.riderDetails?.fullName ?? "",
                  image: rider.riderDetails?.profilePic?.url,
                  driverRideId: myRidesModelData.value.driverRideId,
                  origin: rider.origin?.name?.split(',').first ?? "City",
                  destination:
                      rider.destination?.name?.split(',').first ?? "City",
                  date: DateTimeUtils.formatDate(DateTime.parse(
                      rider.date ?? LocaleKeys.app_defaultDate.tr))));
        } catch (e) {
          Get.toNamed(Routes.CHAT_PAGE,
              arguments: ChatArg(
                  chatRoomId: "",
                  deleteUpdateTime: "",
                  id: rider.riderDetails?.Id,
                  name: rider.riderDetails?.fullName ?? "",
                  image: rider.riderDetails?.profilePic?.url,
                  driverRideId: myRidesModelData.value.driverRideId,
                  origin: rider.origin?.name?.split(',').first ?? "City",
                  destination:
                      rider.destination?.name?.split(',').first ?? "City",
                  date: DateTimeUtils.formatDate(DateTime.parse(
                      rider.date ?? LocaleKeys.app_defaultDate.tr))));
        }
      },
    ));
  }

  toEditRide() {
    Get.toNamed(Routes.MY_RIDES_EDIT, arguments: myRidesModelData.value);
  }

  toShareRide(BuildContext context) async {
    final shareText =
        "Join my ride on Carpooll.com! 🚘\nCheck it out here:\nhttps://carpooll.com/?data=booking&rideId=${myRidesModelData.value.driverRideId}";
    debugPrint(shareText);

    try {
      final box = context.findRenderObject() as RenderBox;
      await Share.share(
        shareText,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      await Share.share(shareText);
    }
  }
}

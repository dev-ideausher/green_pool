import 'package:get/get.dart';

import '../../../data/chat_arg.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class RiderMyRidesSendDetailsController extends GetxController {
  var riderSendRequestModelData = RiderSendRequestModelData();
  var riderRideDetails = RiderSendRequestModelRiderRideDetails();

  @override
  void onInit() {
    super.onInit();
    riderSendRequestModelData = Get.arguments["data"];
    riderRideDetails = Get.arguments["riderRideData"];
  }

  openMessage(RiderSendRequestModelData data) async {
    try {
      final res = await APIManager.postChatRoomId(
          receiverId: data.driverDetails?[0]?.Id ?? "",
          body: {
            "driverRideId": data.Id,
            "riderRideId": riderRideDetails.Id,
            "seatsRequired": riderRideDetails.seatAvailable
          });
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data.driverDetails?[0]?.Id,
              name: data.driverDetails?[0]?.fullName,
              image: data.driverDetails?[0]?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data.driverDetails?[0]?.Id,
              name: data.driverDetails?[0]?.fullName,
              image: data.driverDetails?[0]?.profilePic?.url));
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

import 'package:get/get.dart';
import 'package:green_pool/app/data/rider_confirm_request_model.dart';

import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';

class RiderMyRidesConfirmDetailsController extends GetxController {
  var riderConfirmRequestModel = RiderConfirmRequestModelData();
  RxBool isBtnLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    riderConfirmRequestModel = Get.arguments;
  }

  rejectDriversRequestAPI() async {
    try {
      final response = await APIManager.rejectDriversRequest(
          body: {"ridePostId": riderConfirmRequestModel.Id});
      if (response.data["status"]) {
        Get.find<RiderMyRideRequestController>().allRiderConfirmRequestAPI();
        Get.back();
      } else {
        Get.back();
        showMySnackbar(msg: response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  rejectRidersRequestAPI() async {
    final String ridePostId = "${riderConfirmRequestModel.Id}";

    final Map<String, dynamic> rideData = {"ridePostId": ridePostId};

    try {
      final rejectRiderResponse =
          await APIManager.patchRejectRiderRequest(body: rideData);
      if (rejectRiderResponse.data['status']) {
        Get.find<RiderMyRideRequestController>().allRiderConfirmRequestAPI();
        Get.back();
        showMySnackbar(msg: 'Request rejected successfully!');
      } else {
        showMySnackbar(msg: rejectRiderResponse.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  openMessageFromConfirm(
      RiderConfirmRequestModelDataDriverRideDetails? data) async {
    try {
      isBtnLoading.value = true;
      final res = await APIManager.getChatRoomId(
          receiverId: data?.driverDetails?.firstOrNull?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data?.driverDetails?.firstOrNull?.Id,
              name: data?.driverDetails?.firstOrNull?.fullName ?? "",
              image: data?.driverDetails?.firstOrNull?.profilePic?.url));
      isBtnLoading.value = false;
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data?.driverDetails?.firstOrNull?.Id,
              name: data?.driverDetails?.firstOrNull?.fullName ?? "",
              image: data?.driverDetails?.firstOrNull?.profilePic?.url));
      isBtnLoading.value = false;
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

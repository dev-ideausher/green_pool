import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:green_pool/app/data/ride_detail_id.dart';
import 'package:green_pool/app/services/gp_util.dart';
import '../../../data/chat_arg.dart';
import '../../../data/driver_cofirm_request_model.dart';
import '../../../data/driver_send_request_model.dart';
import '../../../data/send_rider_request_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';
import '../views/booking_confirm_bottom.dart';
import '../views/request_bottom.dart';

class MyRidesRequestController extends GetxController {
  RxBool mapViewType = false.obs;

  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  RxBool isLoading = true.obs;
  final Rx<DriverSendRequestModel> sendRequestModel = DriverSendRequestModel().obs;
  final Rx<DriverConfirmRequestModel> confirmRequestModel = DriverConfirmRequestModel().obs;
  var sendRiderRequestModel = SendRiderRequestModel().obs;
  final Rx<RideDetailId> rideDetailId = RideDetailId().obs;

  @override
  void onInit() async {
    super.onInit();
    rideDetailId.value = Get.arguments;
    await allConfirmRequestAPI();
  }

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
    if (mapViewType.value) {
      // Get.find<MapDriverConfirmRequestController>().on
    } else {}
  }

  allConfirmRequestAPI() async {
    // this api will show all the confirmed rides (which the customer has confrimed that they will go with the particular driver)
    try {
      // need driver id which will come from confirm ride by rider
      final confirmReqResponse = await APIManager.getAllDriverConfirmRequest(driverRideId: rideDetailId.value.driverRidId ?? "");
      var data = jsonDecode(confirmReqResponse.toString());
      confirmRequestModel.value = DriverConfirmRequestModel.fromJson(data);
      isLoading = false.obs;
    } catch (e) {
      // debugPrint(e.toString());
      throw Exception(e);
    }
  }

  acceptRidersRequestAPI(DriverConfirmRequestModelData? driverRideData) async {
    try {
      final acceptRiderResponse = await APIManager.postAcceptRiderRequest(body: {"ridePostId": driverRideData?.Id ?? ""});

      if (acceptRiderResponse.data['status']) {
        allConfirmRequestAPI();
        await Get.bottomSheet(BookingConfirmBottom(driverRideData: driverRideData),isScrollControlled: true);
        showMySnackbar(msg: acceptRiderResponse.data?['message'] ?? 'Request accepted successfully!');
      } else {
        showMySnackbar(msg: acceptRiderResponse.data?['message'] ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  rejectRidersRequestAPI(int index) async {
    final String ridePostId = "${confirmRequestModel.value.data?[index]?.Id}";

    final Map<String, dynamic> rideData = {"ridePostId": ridePostId};

    try {
      final rejectRiderResponse = await APIManager.postRejectRiderRequest(body: rideData);
      var data = jsonDecode(rejectRiderResponse.toString());
      showMySnackbar(msg: 'Request rejected successfully!');
    } catch (e) {
      throw Exception(e);
    }
  }

  allSendRequestAPI() async {
    try {
      isLoading = true.obs;
      final sendReqResponse = await APIManager.getAllDriverSendRequest(driverId: rideDetailId.value.driverRidId ?? "");
      var data = jsonDecode(sendReqResponse.toString());
      sendRequestModel.value = DriverSendRequestModel.fromJson(data);
      isLoading = false.obs;
    } catch (e) {
      throw Exception(e);
    }
  }

  sendRiderRequestAPI(DriverSendRequestModelData driverSendModelData) async {
    final dynamic riderNotificationPref = driverSendModelData.riderDetails?[0]?.notificationPreferences!.toJson();

    try {
      // driver will send request to the customer (from send request view)
      final sendRiderRequestResponse = await APIManager.postSendRequestToRider(body: {
        "riderRideId": driverSendModelData.Id,
        "driverRideId": rideDetailId.value.driverRidId,
        "riderName": driverSendModelData.riderDetails?[0]?.fullName,
        "riderNotificationPreferences": riderNotificationPref
      });
      var data = jsonDecode(sendRiderRequestResponse.toString());
      sendRiderRequestModel.value = SendRiderRequestModel.fromJson(data);
      if (sendRiderRequestModel.value.status ?? false) {
        allSendRequestAPI();
        Get.bottomSheet(const RequestBottom());
      } else {
        showMySnackbar(msg: sendRiderRequestModel.value.message ?? "");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  openMessage(DriverSendRequestModelData data) async {
    try {
      final res = await APIManager.getChatRoomId(receiverId: data.riderDetails?[0]?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              id: data.riderDetails?[0]?.Id,
              name: data.riderDetails?[0]?.fullName,
              image: data.riderDetails?[0]?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(id: data.riderDetails?[0]?.Id, name: data.riderDetails?[0]?.fullName, image: data.riderDetails?[0]?.profilePic?.url));
      debugPrint(e.toString());
    }
  }

  openMessageConfirm(DriverConfirmRequestModelData data) async {
    try {
      final res = await APIManager.getChatRoomId(receiverId: data.rideDetails?[0]?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["chatChannelId"] ?? "",
              id: data.rideDetails?[0]?.Id,
              name: data.rideDetails?[0]?.riderDetails?.first?.fullName ?? "",
              image: data.rideDetails?[0]?.riderDetails?.first?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              id: data.rideDetails?[0]?.Id,
              name: data.rideDetails?[0]?.riderDetails?.first?.fullName,
              image: data.rideDetails?[0]?.riderDetails?.first?.profilePic?.url));
      debugPrint(e.toString());
    }
  }
}

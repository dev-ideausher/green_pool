import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/rider_confirm_request_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../data/chat_arg.dart';
import '../../../data/confirm_ride_by_rider_model.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../services/dio/api_service.dart';
import '../views/request_sent_bottom.dart';

class RiderMyRideRequestController extends GetxController {
  var riderConfirmRequestModel = RiderConfirmRequestModel().obs;
  var riderSendRequestModel = RiderSendRequestModel().obs;
  var confirmRideByRiderModel = ConfirmRideByRiderModel().obs;
  String rideIdFromMyRides = '';
  RxBool isLoading = false.obs;
  RxBool mapViewType = false.obs;

  @override
  void onInit() {
    super.onInit();
    rideIdFromMyRides = Get.arguments;
    method();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  method() async {
    await allRiderConfirmRequestAPI();
    // await allRiderSendRequestAPI();
  }

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
    if (mapViewType.value) {
      // Get.find<MapDriverConfirmRequestController>().on
    } else {}
  }

  allRiderConfirmRequestAPI() async {
    try {
      // need driver id which will come from confirm ride by rider
      isLoading.value = true;
      final confirmReqResponse = await APIManager.getAllRiderConfirmRequest(
          driverRideId: rideIdFromMyRides);
      var data = jsonDecode(confirmReqResponse.toString());
      riderConfirmRequestModel.value = RiderConfirmRequestModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  allRiderSendRequestAPI() async {
    // to view list of drivers available on same route in SendRequest View (riders side)
    try {
      isLoading.value = true;
      final response =
          await APIManager.postAllRiderSendRequest(rideId: rideIdFromMyRides);
      var data = jsonDecode(response.toString());
      riderSendRequestModel.value = RiderSendRequestModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  /*sendRideRequestToDriverAPI(
      RiderSendRequestModelData riderSendRequestModelData) async {
    final String driverRideId = "${riderSendRequestModelData.Id}";
    final String driverId = "${riderSendRequestModelData.driverId}";
    final String driverName =
        "${riderSendRequestModelData.driverDetails?[0]?.fullName}";
    final dynamic driverNotificationPref = riderSendRequestModelData
        .driverDetails?[0]?.notificationPreferences!
        .toJson();

    final Map<String, dynamic> rideData = {
      "riderRideId": rideIdFromMyRides,
      "driverRideId": driverRideId,
      "driverId": driverId,
      "driverName": driverName,
      "driverNotificationPreferences": driverNotificationPref,
      "price": riderSendRequestModelData.price ?? 0
    };
    try {
      final response = await APIManager.postSendRequestToDriver(body: rideData);
      if (response.data['status']) {
        allRiderSendRequestAPI();
        showBottom();
      } else {
        showMySnackbar(msg: response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }*/

  // acceptDriversRequestAPI(int index, {bool showAcceptBottom = false}) async {
  //   try {
  //     final response = await APIManager.acceptDriversRequest(body: {
  //       "ridePostId": riderConfirmRequestModel.value.data?[index]?.Id,
  //       "price":
  //           (riderConfirmRequestModel.value.data?[index]?.price ?? 0).toString()
  //     });
  //     if (response.data['status']) {
  //       allRiderConfirmRequestAPI();
  //       if (showAcceptBottom) {
  //         Get.bottomSheet(RequestAcceptedBottom());
  //       } else {
  //         showMySnackbar(msg: "Request accepted!");
  //         Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
  //       }
  //     } else {
  //       showMySnackbar(msg: response.data['message']);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  rejectDriversRequestAPI(int index) async {
    try {
      final response = await APIManager.rejectDriversRequest(body: {
        "ridePostId": riderConfirmRequestModel.value.data?[index]?.Id
      });
      if (response.data["status"]) {
        allRiderConfirmRequestAPI();
        Get.back();
        showMySnackbar(msg: response.data["message"]);
      } else {
        Get.back();
        showMySnackbar(msg: response.data["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  openMessage(RiderSendRequestModelData data) async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: data.driverDetails?[0]?.Id ?? "");
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

  openMessageFromConfirm(
      RiderConfirmRequestModelDataDriverRideDetails? data) async {
    try {
      final res = await APIManager.getChatRoomId(
          receiverId: data?.driverDetails?.firstOrNull?.Id ?? "");
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data?.driverDetails?.firstOrNull?.Id,
              name: data?.driverDetails?.firstOrNull?.fullName ?? "",
              image: data?.driverDetails?.firstOrNull?.profilePic?.url));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data?.driverDetails?.firstOrNull?.Id,
              name: data?.driverDetails?.firstOrNull?.fullName ?? "",
              image: data?.driverDetails?.firstOrNull?.profilePic?.url));
    }
  }

  void showBottom() {
    Get.bottomSheet(RequestSentBottom());
  }

  moveToPaymentFromConfirmSection(
      RiderConfirmRequestModelData riderConfirmRequestModelData) {
    Get.toNamed(Routes.PAYMENT, arguments: {
      "ridePostId": riderConfirmRequestModelData.Id,
      "price": ((riderConfirmRequestModelData.price)! *
              (riderConfirmRequestModelData.riderRideDetails!.seatAvailable!))
          .toString(),
      'riderConfirmRequestModelData': riderConfirmRequestModelData,
      'pricePerSeat': riderConfirmRequestModelData.price
    });
  }

  moveToPaymentFromSendRequest(
      //need to multiply by no of seats
      RiderSendRequestModelData riderSendRequestModelData) async {
    final String driverRideId = "${riderSendRequestModelData.Id}";
    final String driverId = "${riderSendRequestModelData.driverId}";
    final String driverName =
        "${riderSendRequestModelData.driverDetails?[0]?.fullName}";
    final dynamic driverNotificationPref = riderSendRequestModelData
        .driverDetails?[0]?.notificationPreferences!
        .toJson();

    final Map<String, dynamic> rideData = {
      "riderRideId": rideIdFromMyRides,
      "driverRideId": driverRideId,
      "driverId": driverId,
      "driverName": driverName,
      "driverNotificationPreferences": driverNotificationPref,
      "price": int.parse(riderSendRequestModelData.price!) *
          (riderSendRequestModel.value.riderRideDetails!.seatAvailable!)
    };

    print(
        "PRICE: ${int.parse(riderSendRequestModelData.price!) * (riderSendRequestModel.value.riderRideDetails!.seatAvailable!)}");

    Get.toNamed(Routes.PAYMENT, arguments: {
      'rideData': rideData,
      'riderSendRequestModelData': riderSendRequestModelData,
      'pricePerSeat': riderSendRequestModelData.price,
      'seatsBooked': riderSendRequestModel.value.riderRideDetails!.seatAvailable
    });
  }

  void moveToDetailsPage(RiderSendRequestModelData data) {
    Get.toNamed(Routes.RIDER_MY_RIDES_SEND_DETAILS, arguments: data);
  }
}

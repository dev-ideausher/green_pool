import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/data/rider_confirm_request_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import '../../../data/confirm_ride_by_rider_model.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../services/dio/api_service.dart';

class RiderMyRideRequestController extends GetxController {
  var riderConfirmRequestModel = RiderConfirmRequestModel().obs;
  var riderSendRequestModel = RiderSendRequestModel().obs;
  var confirmRideByRiderModel = ConfirmRideByRiderModel().obs;
  String rideIdFromMyRides = '';

  @override
  void onInit() {
    super.onInit();
    rideIdFromMyRides = Get.arguments;
    // allRiderConfirmRequestAPI();
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

  allRiderConfirmRequestAPI() async {
    try {
      // need driver id which will come from confirm ride by rider
      final confirmReqResponse = await APIManager.getAllRiderConfirmRequest(
          driverRideId: rideIdFromMyRides);
      var data = jsonDecode(confirmReqResponse.toString());
      riderConfirmRequestModel.value = RiderConfirmRequestModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  allRiderSendRequestAPI() async {
    // to view list of drivers available on same route in SendRequest View (riders side)
    try {
      final response =
          await APIManager.postAllRiderSendRequest(rideId: rideIdFromMyRides);
      var data = jsonDecode(response.toString());
      riderSendRequestModel.value = RiderSendRequestModel.fromJson(data);
      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }

  sendRideRequestToDriverAPI(int index) async {
    //rider will send request to matching drivers going on the same path (in rider send request section)
    // and
    //rider can accept the request sent by driver (in rider confirm request section)

    final String driverRideId =
        "${riderSendRequestModel.value.data?[index]?.Id}";
    final String driverId =
        "${riderSendRequestModel.value.data?[index]?.driverId}";

    final Map<String, dynamic> rideData = {
      "riderRideId":
          rideIdFromMyRides, //! rideId is  riders ride Id in this case
      "driverRideId": driverRideId,
      "driverId": driverId
    };
    try {
      final response = await APIManager.postSendRequestToDriver(body: rideData);
      // var data = jsonDecode(response.toString());
      // confirmRideByRiderModel.value = ConfirmRideByRiderModel.fromJson(data);
      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }

  acceptDriversRequestAPI(int index) async {
    //rider will send request to matching drivers going on the same path (in rider send request section)
    // and
    //rider can accept the request sent by driver (in rider confirm request section)

    final String riderRideId =
        "${riderConfirmRequestModel.value.data?[index]?.Id}";

    final Map<String, dynamic> rideData = {
      "ridePostId": riderRideId,
    };
    try {
      final response = await APIManager.acceptDriversRequest(body: rideData);
      var data = jsonDecode(response.toString());
      log(data.toString());
      // confirmRideByRiderModel.value = ConfirmRideByRiderModel.fromJson(data);
      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }

  rejectDriversRequestAPI(int index) async {
    //rider will send request to matching drivers going on the same path (in rider send request section)
    // and
    //rider can accept the request sent by driver (in rider confirm request section)

    final String riderRideId =
        "${riderConfirmRequestModel.value.data?[index]?.Id}";

    final Map<String, dynamic> rideData = {
      "ridePostId": riderRideId,
    };
    try {
      final response = await APIManager.rejectDriversRequest(body: rideData);
      showMySnackbar(msg: "Ride rejected successfully");
      Get.back();
      var data = jsonDecode(response.toString());
      log(data.toString());
      // confirmRideByRiderModel.value = ConfirmRideByRiderModel.fromJson(data);
      // log("This is driver ride Id: ${matchingRideResponse.value.data?[0]?.Id}");
    } catch (e) {
      throw Exception(e);
    }
  }
}

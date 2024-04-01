import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

import '../../../data/accept_rider_request_model.dart';
import '../../../data/driver_cofirm_request_model.dart';
import '../../../data/driver_send_request_model.dart';
import '../../../data/send_rider_request_model.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';

class MyRidesRequestController extends GetxController {
  RxBool mapViewType = false.obs;
  String driverRideId = '';
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  var sendRequestModel = DriverSendRequestModel().obs;
  var acceptRiderRequestModel = AcceptRiderRequestModel().obs;
  var confirmRequestModel = DriverCofirmRequestModel().obs;
  var sendRiderRequestModel = SendRiderRequestModel().obs;

  @override
  void onInit() async {
    super.onInit();
    driverRideId = Get.arguments;
    await allConfirmRequestAPI();
  }

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
  }

  allSendRequestAPI() async {
    try {
      final sendReqResponse =
          await APIManager.getAllDriverSendRequest(driverId: driverRideId);
      var data = jsonDecode(sendReqResponse.toString());
      sendRequestModel.value = DriverSendRequestModel.fromJson(data);
      //!
      //TODO index instead of 0
      // riderRideId = "${sendRequestModel.value.data?[0]?.Id}";
      // distance = sendRequestModel.value.data?[0]?.minStopDistance;
      //for distance
      //check which is smaller
      //distanceFromOrigin or minStopDistance
    } catch (e) {
      throw Exception(e);
    }
  }

  sendRiderRequestAPI(int index) async {
    final String riderRideId = "${sendRequestModel.value.data?[index]?.Id}";
    final int? distance = sendRequestModel.value.data?[index]?.minStopDistance;

    final Map<String, dynamic> rideData = {
      "riderRideId": riderRideId,
      "driverRideId": driverRideId,
      "distance": distance,
    };

    try {
      // driver will send request to the customer (from send request view)
      final sendRiderRequestResponse =
          await APIManager.postDriverSendRiderRequest(body: rideData);
      var data = jsonDecode(sendRiderRequestResponse.toString());
      sendRiderRequestModel.value = SendRiderRequestModel.fromJson(data);
      showMySnackbar(msg: 'Request sent successfully');
    } catch (e) {
      throw Exception(e);
    }
  }

  allConfirmRequestAPI() async {
    // this api will show all the confirmed rides (which the customer has confrimed that they will go with the particular driver)
    try {
      // need driver id which will come from confirm ride by rider
      final confirmReqResponse = await APIManager.getAllDriverConfirmRequest(
          driverRideId: driverRideId);
      var data = jsonDecode(confirmReqResponse.toString());
      confirmRequestModel.value = DriverCofirmRequestModel.fromJson(data);
      //!
      //TODO index instead of 0
      // ridePostId = "${confirmRequestModel.value.data?[0]?.Id}";
      // print(ridePostId);
    } catch (e) {
      throw Exception(e);
    }
  }

  acceptRidersRequestAPI(int index) async {
    // to accept the ride requests that have been sent by the customer

    final String ridePostId = "${confirmRequestModel.value.data?[index]?.Id}";

    final Map<String, dynamic> rideData = {
      "ridePostId": ridePostId,
      "status": {
        'confirmByDriver': true,
      },
    };

    try {
      final acceptRiderResponse =
          await APIManager.postAcceptRiderRequest(body: rideData);
      var data = jsonDecode(acceptRiderResponse.toString());
      log(data);
      acceptRiderRequestModel.value = AcceptRiderRequestModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}

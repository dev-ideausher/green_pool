import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';

class FindRideController extends GetxController {
  bool isDriver = false;
  TextEditingController seatAvailable = TextEditingController();
  int numberOfSeatAvailable = 0;

  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  double riderOriginLat = 0.0;
  double riderOriginLong = 0.0;
  TextEditingController riderOriginTextController = TextEditingController();
  double riderDestinationLat = 0.0;
  double riderDestinationLong = 0.0;
  TextEditingController riderDestinationTextController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  decideRouting() async {
    if (Get.find<GetStorageService>().getLoggedIn) {
      //? for testing updateDetailsAPI
      // Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: isDriver);
      //?original flow
      // Get.toNamed(Routes.MATCHING_RIDES, arguments: isDriver);
      await driverPostRideAPI();
    } else {
      Get.offNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }

  driverPostRideAPI() async {
    final findRideData = FindRideModel(
      ridesDetails: FindRideModelRidesDetails( 
        date: date.value.text,
        seatAvailable: numberOfSeatAvailable,
        time: time.text,
        destination: FindRideModelRidesDetailsDestination(
          latitude: riderOriginLat,
          longitude: riderOriginLong,
          name: riderOriginTextController.value.text,
        ),
        origin: FindRideModelRidesDetailsOrigin(
          latitude: riderDestinationLat,
          longitude: riderDestinationLong,
          name: riderDestinationTextController.value.text,
        ),
      ),
    );
    try {
      final findRideDataJson = findRideData.toJson();
      final response =
          await APIManager.postRiderFindRide(body: findRideDataJson);
      showMySnackbar(msg: "Ride posted successfully");
      await Get.offNamed(Routes.MATCHING_RIDES);
      log(response.data.toString());
    } catch (e) {
      showMySnackbar(msg: 'Please fill in correct details');
      throw Exception(e);
    }
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      date.text = formattedDate;
    }
  }
}

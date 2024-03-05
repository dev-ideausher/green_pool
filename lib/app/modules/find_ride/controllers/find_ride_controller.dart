import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';

import '../../../data/find_ride_response_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';

class FindRideController extends GetxController {
  bool isDriver = false;
  TextEditingController seatAvailable = TextEditingController();
  int numberOfSeatAvailable = 0;
  RxBool isActive = false.obs;

  TextEditingController date = TextEditingController();
  TextEditingController departureDate = TextEditingController();
  // TextEditingController time = TextEditingController();
  TextEditingController selectedTime = TextEditingController();
  double riderOriginLat = 0.0;
  double riderOriginLong = 0.0;
  TextEditingController riderOriginTextController = TextEditingController();
  double riderDestinationLat = 0.0;
  double riderDestinationLong = 0.0;
  TextEditingController riderDestinationTextController =
      TextEditingController();
  // GlobalKey<FormState> validationKey = GlobalKey<FormState>();

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
      await riderPostRideAPI();
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }

  var rideresponse = FindRideResponseModel().obs;

  riderPostRideAPI() async {
    final findRideData = FindRideModel(
      ridesDetails: FindRideModelRidesDetails(
        date: date.value.text,
        seatAvailable: int.parse(seatAvailable.value.text),
        time: selectedTime.value.text,
        origin: FindRideModelRidesDetailsOrigin(
          latitude: riderOriginLat,
          longitude: riderOriginLong,
          name: riderOriginTextController.value.text,
        ),
        destination: FindRideModelRidesDetailsDestination(
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

      var data = jsonDecode(response.toString());
      rideresponse.value = FindRideResponseModel.fromJson(data);
      final String riderRideId = "${rideresponse.value.data![0]?.Id}";
      log("this is riders ride id: $riderRideId");

      if (rideresponse.value.status!) {
        showMySnackbar(msg: "Ride posted successfully");
      } else {
        showMySnackbar(msg: "Ride already posted");
      }

      await Get.toNamed(Routes.MATCHING_RIDES, arguments: riderRideId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            // Define the custom theme for the date picker
            data: ThemeData(
              // Define the primary color
              primaryColor: Colors.green,
              // Define the color scheme for the date picker
              colorScheme: ColorScheme.light(
                // Define the primary color for the date picker
                primary: Colors.green,
                // Define the background color for the date picker
                surface: Colors.white,
                // Define the on-primary color for the date picker
                onPrimary: Colors.white,
              ),
            ),
            // Apply the custom theme to the child widget
            child: child!,
          );
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      String isoFormattedDate = pickedDate.toIso8601String();
      date.text = isoFormattedDate;
      departureDate.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }
  // Future<void> setDate(BuildContext context) async {
  //   DateTime minimumDate = DateTime.now();
  //   DateTime? pickedDate = await showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext builder) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height / 3,
  //         child: CupertinoDatePicker(
  //           initialDateTime: minimumDate,
  //           minimumDate: minimumDate,
  //           maximumDate: minimumDate.add(const Duration(days: 3 * 30)),
  //           mode: CupertinoDatePickerMode.date,
  //           onDateTimeChanged: (DateTime dateTime) {},
  //         ),
  //       );
  //     },
  //   );

  //   if (pickedDate != null) {
  //     String isoFormattedDate = pickedDate.toIso8601String();
  //     date.text = isoFormattedDate;
  //     departureDate.text =
  //         "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
  //   }
  // }

  Future<void> setTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      selectedTime.text = formattedTime.toString();
    }
  }

  setActiveState() {
    if (riderOriginTextController.value.text.isNotEmpty &&
        riderDestinationTextController.value.text.isNotEmpty &&
        date.value.text.isNotEmpty &&
        selectedTime.value.text.isNotEmpty &&
        seatAvailable.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/colors.dart';

import '../../../data/find_ride_response_model.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
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
  TextEditingController descriptionTextController = TextEditingController();
  double riderOriginLat = 0.0;
  double riderOriginLong = 0.0;
  TextEditingController riderOriginTextController = TextEditingController();
  double riderDestinationLat = 0.0;
  double riderDestinationLong = 0.0;
  TextEditingController riderDestinationTextController =
      TextEditingController();
  // GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  final Rx<MatchingRidesModel> matchingRidesModel = MatchingRidesModel().obs;

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
      if (Get.find<HomeController>().userInfo.value.data?.profileStatus ==
          true) {
        await getMatchingRidesAPI();
      } else {
        Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: false);
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: {
        'isDriver': isDriver,
        'fromNavBar': false,
        'findRideModel': FindRideModel(
          ridesDetails: FindRideModelRidesDetails(
            date: date.value.text,
            seatAvailable: int.parse(seatAvailable.value.text),
            time: selectedTime.value.text,
            description: descriptionTextController.value.text,
            pinkMode: Get.find<GetStorageService>().isPinkMode,
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
        ),
      });
    }
  }

  var rideresponse = FindRideResponseModel().obs;

  getMatchingRidesAPI() async {
    final findRideData = FindRideModel(
      ridesDetails: FindRideModelRidesDetails(
        date: date.value.text,
        seatAvailable: int.parse(seatAvailable.value.text),
        time: selectedTime.value.text,
        description: descriptionTextController.value.text,
        pinkMode: Get.find<GetStorageService>().isPinkMode,
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
          await APIManager.postMatchngRides(body: findRideDataJson);
      var data = jsonDecode(response.toString());
      matchingRidesModel.value = MatchingRidesModel.fromJson(data);
      Get.toNamed(Routes.MATCHING_RIDES, arguments: {
        'findRideData': findRideDataJson,
        'matchingRidesModel': matchingRidesModel.value
      });
    } catch (error) {
      throw Exception(error);
    }
  }

  riderPostRideAPI() async {
    final findRideData = FindRideModel(
      ridesDetails: FindRideModelRidesDetails(
        date: date.value.text,
        seatAvailable: int.parse(seatAvailable.value.text),
        time: selectedTime.value.text,
        description: descriptionTextController.value.text,
        pinkMode: Get.find<GetStorageService>().isPinkMode,
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

      // if (rideresponse.value.status!) {
      //   showMySnackbar(msg: "Ride posted successfully");
      // } else {
      //   showMySnackbar(msg: "Ride already posted");
      // }

      // await Get.toNamed(Routes.MATCHING_RIDES, arguments: riderRideId);
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
              primaryColor: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the color scheme for the date picker
              colorScheme: ColorScheme.light(
                // Define the primary color for the date picker
                primary: Get.find<HomeController>().isPinkModeOn.value
                    ? ColorUtil.kPrimaryPinkMode
                    : ColorUtil.kPrimary01,
                // Define the background color for the date picker
                surface: Colors.white,
                // Define the on-primary color for the date picker
                onPrimary: Colors.white,
                secondary: Get.find<HomeController>().isPinkModeOn.value
                    ? ColorUtil.kPrimaryPinkMode
                    : ColorUtil.kPrimary01,
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<HomeController>().isPinkModeOn.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
            ),
          ),
          // Apply the custom theme to the child widget
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      selectedTime.text = formattedTime.toString();
    }
  }

  setActiveState() {
    if (riderOriginTextController.value.text.isNotEmpty &&
        riderDestinationTextController.value.text.isNotEmpty &&
        seatAvailable.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  String? seatsValidator(int? value) {
    // Check if the value is null
    if (value == null) {
      return 'Please enter a value';
    }

    // Check if the integer value is between 1 and 6
    if (value < 1 || value > 6) {
      return 'Please enter an integer between 1 and 6';
    }

    // If all validations pass, return null (indicating no error)
    return null;
  }
}

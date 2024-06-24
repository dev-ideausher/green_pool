import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/location_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/find_ride_response_model.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';

class FindRideController extends GetxController {
  bool isDriver = false;
  TextEditingController seatAvailable = TextEditingController();
  int numberOfSeatAvailable = 1;
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
  RxList<LocationModel> locationModelNames = <LocationModel>[].obs;

  // GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  final Rx<MatchingRidesModel> matchingRidesModel = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    final now = TimeOfDay.now();
    seatAvailable.text = numberOfSeatAvailable.toString();
    final pickedDate = DateTime.now();
    date.text = pickedDate.toIso8601String();
    departureDate.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    selectedTime.text = TimeOfDay(hour: now.hour + 1, minute: 0)
        .format(Get.context!)
        .toString();
    isDriver = Get.arguments;
    // Get.find<GetStorageService>().locationsName = "";
    try {
      if (Get.find<GetStorageService>().locationsName.toString().isNotEmpty) {
        print("location Names" +
            Get.find<GetStorageService>().locationsName.toString());
        List<dynamic> locationListMap =
            jsonDecode(Get.find<GetStorageService>().locationsName);

        locationModelNames.value = locationListMap
            .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
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

  decideRouting() async {
    if (Get.find<GetStorageService>().isLoggedIn) {
      if (Get.find<HomeController>().userInfo.value.data?.profileStatus ==
          true) {
        LocationModel locationModel = LocationModel(
            originLocation: LocationModelOriginLocation(
              lat: riderOriginLat,
              long: riderOriginLong,
              nameOfLocation: riderOriginTextController.value.text,
            ),
            destinationLocation: LocationModelDestinationLocation(
              lat: riderDestinationLat,
              long: riderDestinationLong,
              nameOfLocation: riderDestinationTextController.value.text,
            ));

        locationModelNames.add(locationModel);
        String pickUpDropoffData = jsonEncode(locationModelNames);

        Get.find<GetStorageService>().locationsName = pickUpDropoffData;

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
      final response = await APIManager.postMatchngRides(
          body: findRideDataJson, queryParam: "");
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
      showMySnackbar(msg: "Same ride is already posted");
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

  Future<void> setTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
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
        riderDestinationTextController.value.text.isNotEmpty) {
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

  void setLocation(int index) {
    riderOriginLat = locationModelNames?[index]?.originLocation?.lat ?? 0.0;
    riderOriginLong = locationModelNames?[index]?.originLocation?.long ?? 0.0;
    riderOriginTextController.text =
        locationModelNames?[index]?.originLocation?.nameOfLocation ?? "";

    riderDestinationLat =
        locationModelNames?[index]?.destinationLocation?.lat ?? 0.0;
    riderDestinationLong =
        locationModelNames?[index]?.destinationLocation?.long ?? 0.0;
    riderDestinationTextController.text =
        locationModelNames?[index]?.destinationLocation?.nameOfLocation ?? "";
  }

  // void selectLocation(index) {
  //   final storageService = Get.find<GetStorageService>();
  //   DialogHelper.selectOriginOrDestination(() {
  //     //on pressed pickup
  //     riderOriginLat = storageService.locations[index][0];
  //     riderOriginLong = storageService.locations[index][1];
  //     riderOriginTextController.text = storageService.locations[index][2];
  //     Get.back();
  //     setActiveState();
  //   }, () {
  //     //on pressed drop off
  //     riderDestinationLat = storageService.locations[index][0];
  //     riderDestinationLong = storageService.locations[index][1];
  //     riderDestinationTextController.text = storageService.locations[index][2];
  //     Get.back();
  //     setActiveState();
  //   });
}

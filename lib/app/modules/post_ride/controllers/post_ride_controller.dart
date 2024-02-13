import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../../home/views/bottom_navigation_view.dart';
import '../views/carpool_schedule_view.dart';

class PostRideController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxString tripType = ''.obs;
  TextEditingController selectedDateOneTime = TextEditingController();
  TextEditingController selectedTimeOneTime = TextEditingController();
  RxBool isReturn = false.obs;
  TextEditingController selectedDateReturnTrip = TextEditingController();
  TextEditingController selectedTimeReturnTrip = TextEditingController();
  final RxInt count = 0.obs;

  List<RxBool> switchStates = List.generate(8, (index) => false.obs);

  RxBool isChecked = false.obs;
  bool isDriver = false;
  bool isOrigin = false;

  TextEditingController originTextController = TextEditingController();

  TextEditingController destinationTextController = TextEditingController();
  TextEditingController addStopsTextController = TextEditingController();
  TextEditingController stop1TextController = TextEditingController();
  TextEditingController stop2TextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  int pricePerSeat = 0;

  PostRideModel postRideModel = PostRideModel();
  RxDouble originLatitude = 0.0.obs;
  RxDouble originLongitude = 0.0.obs;
  RxDouble destLatitude = 0.0.obs;
  RxDouble destLongitude = 0.0.obs;
  RxDouble stop1Lat = 0.0.obs;
  RxDouble stop1Long = 0.0.obs;
  RxDouble stop2Lat = 0.0.obs;
  RxDouble stop2Long = 0.0.obs;
  // RxString originAddress = ''.obs;
  // RxString destinationAddress = ''.obs;

  //luggage allowance
  // List<RxBool> luggageAllowance = List.generate(4, (index) => false.obs);
  RxBool noLuggage = false.obs;
  RxBool smallLuggage = false.obs;
  RxBool mediumLuggage = false.obs;
  RxBool largeLuggage = false.obs;

  //amenities
  RxBool appreciatesConversation = false.obs;
  RxBool enjoysMusic = false.obs;
  RxBool smokeFree = false.obs;
  RxBool petFriendly = false.obs;
  RxBool winterTires = false.obs;
  RxBool coolingOrHeating = false.obs;
  RxBool babySeat = false.obs;
  RxBool heatedSeats = false.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => CreateAccountController());
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

  //! after logging in it should still check whether the user and vehicle data is filled or not: but it directly goes to the carpool schedule page
  decideRouting() {
    // Decides if the user is logged in and redirects accordingly
    if (Get.find<GetStorageService>().getLoggedIn) {
      //? for testing updateDetailsAPI
      // Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);

      //? the original flow
      Get.to(() => const CarpoolScheduleView(), arguments: isDriver);
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }

  driverPostRideAPI() async {
    tripType.value = setTripType() ?? '';

    final postRideData = PostRideModel(
        ridesDetails: PostRideModelRidesDetails(
      origin: PostRideModelRidesDetailsOrigin(
        latitude: originLongitude.value,
        longitude: originLatitude.value,
        name: originTextController.value.text,
      ),
      destination: PostRideModelRidesDetailsDestination(
        latitude: destLatitude.value,
        longitude: destLongitude.value,
        name: destinationTextController.value.text,
      ),
      stops: [
        PostRideModelRidesDetailsStops(
          latitude: stop1Lat.value,
          longitude: stop1Long.value,
          name: stop1TextController.value.text,
        ),
        PostRideModelRidesDetailsStops(
          latitude: stop2Lat.value,
          longitude: stop2Long.value,
          name: stop2TextController.value.text,
        ),
      ],
      // for trip type if tab index is 0 then one Time trip
      tripType: tripType.value,
      date: selectedDateOneTime.text,
      time: selectedTimeOneTime.text,
      //have to calculate distance between every stop and fair will be calculated accordingly
      fair: pricePerSeat,
      preferences: PostRideModelRidesDetailsPreferences(
        seatAvailable: count.value,
        luggageType: "M",
        other: [
          PostRideModelRidesDetailsPreferencesOther(
            AppreciatesConversation: appreciatesConversation.value,
            EnjoysMusic: enjoysMusic.value,
            SmokeFree: smokeFree.value,
            PetFriendly: petFriendly.value,
            WinterTires: winterTires.value,
            CoolingOrHeating: coolingOrHeating.value,
            BabySeat: babySeat.value,
            HeatedSeats: heatedSeats.value,
          )
        ],
      ),
      returnTrip: PostRideModelRidesDetailsReturnTrip(
        isReturnTrip: isReturn.value,
        returnDate: selectedDateReturnTrip.text,
        returnTime: selectedTimeReturnTrip.text,
      ),
    ));
    try {
      final postRideDataJson = postRideData.toJson();
      final response =
          await APIManager.postDriverPostRide(body: postRideDataJson);
      showMySnackbar(msg: "Ride posted successfully");
      await Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      log(response.data.toString());
    } catch (e) {
      showMySnackbar(msg: 'Please fill in correct details');
      // throw Exception(e);
    }
  }

  String? setTripType() {
    //will send One time trip or recurring trip
    if (tabIndex.value == 0) {
      return "oneTime";
    } else {
      return "recurring";
    }
  }

  String getTextAtIndex(int index) {
    // to update the luggage weight according to the chip selected
    switch (index) {
      case 0:
        return '0 kg';
      case 1:
        return '10 kg';
      case 2:
        return '15 kg';
      case 3:
        return '20 kg';
      default:
        return '';
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
      selectedDateOneTime.text = formattedDate;
    }
  }

  Future<void> setReturnDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      // String formattedDate = pickedDate.toString().split(" ")[0];
      String formattedDate = pickedDate.toIso8601String();
      selectedDateReturnTrip.text = formattedDate;
    }
  }

  bool setReturn() {
    //handles Return Trip section in carpool scheduling
    isReturn.value = !isReturn.value;
    return isReturn.value;
  }

  void toggleCheckbox() {
    //handles checkbox state in guidelines view
    isChecked.value = !isChecked.value;
  }

  void setGuideLines() {
    //handles button state in guidelines view
    if (isChecked.value == true) {
      try {
        driverPostRideAPI();
      } catch (e) {
        throw Exception(e);
      }
    } else {
      showMySnackbar(msg: 'Terms and Conditions not accepted');
    }
  }

  // void setSelected(int selectedIndex) {
  //   //sets selected state of the luggage chip
  //   for (int i = 0; i < luggageAllowance.length; i++) {
  //     luggageAllowance[i](i == selectedIndex);
  //   }
  // }

  void toggleSwitch(int index) {
    //handles amenities toggle button
    switchStates[index].value = !switchStates[index].value;
  }

  void increment() {
    //handles available seat number
    if (count.value <= 2) {
      count.value++;
    }
  }

  void decrement() {
    //handles available seat number
    if (count.value >= 1) {
      count.value--;
    }
  }

  void selectLuggage(RxBool selected) {
    // to select the luggage choice chips
    if (selected == noLuggage) {
      smallLuggage.value = false;
      mediumLuggage.value = false;
      largeLuggage.value = false;
    } else if (selected == smallLuggage) {
      noLuggage.value = false;
      mediumLuggage.value = false;
      largeLuggage.value = false;
    } else if (selected == mediumLuggage) {
      noLuggage.value = false;
      smallLuggage.value = false;
      largeLuggage.value = false;
    } else if (selected == largeLuggage) {
      noLuggage.value = false;
      smallLuggage.value = false;
      mediumLuggage.value = false;
    }
    selected.value = true;
  }
}

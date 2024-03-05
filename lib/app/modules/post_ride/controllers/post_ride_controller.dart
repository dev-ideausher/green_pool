import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../../origin/controllers/origin_controller.dart';
import '../views/carpool_schedule_view.dart';

class PostRideController extends GetxController {
  RxInt tabIndex = 0.obs;
  RxString tripType = ''.obs;
  TextEditingController selectedDateOneTime = TextEditingController();
  TextEditingController formattedOneTimeDate = TextEditingController();
  TextEditingController selectedTimeOneTime = TextEditingController();
  RxBool isReturn = false.obs;
  TextEditingController selectedDateReturnTrip = TextEditingController();
  TextEditingController formattedReturnDate = TextEditingController();
  TextEditingController selectedTimeReturnTrip = TextEditingController();
  final RxInt count = 1.obs;
  RxBool isActive = false.obs;
  RxBool isActiveCarpoolButton = false.obs;
  RxBool isActivePricingButton = false.obs;

  TextEditingController selectedRecurringTime = TextEditingController();

  List<RxBool> switchStates = List.generate(8, (index) => false.obs);

  RxBool isChecked = false.obs;
  bool isDriver = false;

  RxDouble originLatitude = 0.0.obs;
  RxDouble originLongitude = 0.0.obs;
  TextEditingController originTextController = TextEditingController();
  RxDouble destLatitude = 0.0.obs;
  RxDouble destLongitude = 0.0.obs;
  TextEditingController destinationTextController = TextEditingController();
  RxDouble stop1Lat = 0.0.obs;
  RxDouble stop1Long = 0.0.obs;
  TextEditingController stop1TextController = TextEditingController();
  RxDouble stop2Lat = 0.0.obs;
  RxDouble stop2Long = 0.0.obs;
  TextEditingController stop2TextController = TextEditingController();

  TextEditingController priceTextController = TextEditingController();

  //luggage allowance
  RxBool noLuggage = false.obs;
  RxBool smallLuggage = false.obs;
  RxBool mediumLuggage = false.obs;
  RxBool largeLuggage = false.obs;
  RxString selectedCHIP = 'No'.obs;

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
      if (Get.find<ProfileController>().userInfo.value.data?.vehicleStatus ==
          false) {
        showMySnackbar(msg: 'Please fill in vehicle details');
        Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);
      } else {
        //? for testing updateDetailsAPI
        // Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);

        //? the original flow
        Get.to(() => const CarpoolScheduleView(), arguments: isDriver);
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }

  driverPostRideAPI() async {
    tripType.value = setTripType() ?? '';

    final postRideData = PostRideModel(
        ridesDetails: PostRideModelRidesDetails(
      origin: PostRideModelRidesDetailsOrigin(
        latitude: originLatitude.value,
        longitude: originLongitude.value,
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
      fair: int.parse(priceTextController.value.text),
      preferences: PostRideModelRidesDetailsPreferences(
        seatAvailable: count.value,
        luggageType: selectedCHIP.value,
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
      throw Exception(e);
    }
  }

  String? fareValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter a reasonable cost';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^\d{1,4}\.?\d{0,2}$');

    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a reasonable cost';
    }

    return null; // Return null if the value is valid
  }

  String? setTripType() {
    //will send One time trip or recurring trip
    if (tabIndex.value == 0) {
      return "oneTime";
    } else {
      return "recurring";
    }
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      selectedDateOneTime.text = formattedDate;
      formattedOneTimeDate.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> setReturnDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      selectedDateReturnTrip.text = formattedDate;
      formattedReturnDate.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> setTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      selectedTimeOneTime.text = formattedTime.toString();
    }
  }

  Future<void> setReturnTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      selectedTimeReturnTrip.text = formattedTime.toString();
    }
  }

  Future<void> setRecurringTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      selectedRecurringTime.text = formattedTime.toString();
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
    if (count.value <= 5) {
      count.value++;
    }
  }

  void decrement() {
    //handles available seat number
    if (count.value >= 2) {
      count.value--;
    }
  }

// ignore_for_file: unnecessary_null_comparison
  setActiveStatePostRideView() {
    if (originTextController.value.text != null &&
        destinationTextController.value.text != null) {
      return isActive.value = true;
    } else {
      return isActive.value = false;
    }
  }

  setActive() async {
    if (await Get.toNamed(Routes.ORIGIN, arguments: LocationValues.origin)) {
      update();
    } else {}
  }

  setActiveStateCarpoolSchedule() {
    if ((formattedOneTimeDate.value.text == null ||
            formattedOneTimeDate.value.text == '') &&
        (selectedTimeOneTime.value.text == null ||
            selectedTimeOneTime.value.text == '')) {
      isActiveCarpoolButton.value = false;
    } else {
      isActiveCarpoolButton.value = true;
    }
  }

  setActiveStatePricing() {
    if ((priceTextController.value.text == null ||
        priceTextController.value.text == '' ||
        priceTextController.value.text == '0')) {
      isActivePricingButton.value = false;
    } else if ((formattedOneTimeDate.value.text == null ||
            formattedOneTimeDate.value.text == '') &&
        (selectedTimeOneTime.value.text == null ||
            selectedTimeOneTime.value.text == '')) {
      isActivePricingButton.value = false;
      showMySnackbar(
          msg: 'Please select correct time and date for scheduling the ride');
    } else {
      isActivePricingButton.value = true;
    }
  }
}

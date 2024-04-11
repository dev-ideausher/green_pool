import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../../origin/controllers/origin_controller.dart';

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
  TextEditingController descriptionTextController = TextEditingController();
  final RxInt count = 1.obs;
  RxBool isActive = false.obs;
  RxBool viewPrice = false.obs;
  RxBool isActiveCarpoolButton = false.obs;
  RxBool isActivePricingButton = false.obs;
  RxBool isStop1Added = false.obs;

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
  TextEditingController price2TextController = TextEditingController();
  TextEditingController price3TextController = TextEditingController();
  TextEditingController price4TextController = TextEditingController();
  TextEditingController price5TextController = TextEditingController();
  TextEditingController price6TextController = TextEditingController();

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

  //for Days of week
  // List<String> daysOfWeek = [];
  RxBool isMonday = false.obs;
  RxBool isTuesday = false.obs;
  RxBool isWednesday = false.obs;
  RxBool isThursDay = false.obs;
  RxBool isFriday = false.obs;
  RxBool isSaturday = false.obs;
  RxBool isSunday = false.obs;
  List<int?>? daysOfWeek = <int>[].obs;

  final RxString luggageWeight = ''.obs;

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

  decideRouting() {
    // Decides if the user is logged in and redirects accordingly
    if (Get.find<GetStorageService>().getLoggedIn) {
      if (Get.find<HomeController>().userInfo.value.data?.vehicleStatus ==
          false) {
        showMySnackbar(msg: 'Please fill in vehicle details');
        Get.toNamed(Routes.PROFILE_SETUP);
      } else {
        Get.toNamed(Routes.CARPOOL_SCHEDULE);
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
        originDestinationFair: priceTextController.value.text,
      ),
      destination: PostRideModelRidesDetailsDestination(
        latitude: destLatitude.value,
        longitude: destLongitude.value,
        name: destinationTextController.value.text,
      ),
      stops: [
        //? is stop 1 added?
        PostRideModelRidesDetailsStops(
            latitude: stop1Lat.value,
            longitude: stop1Long.value,
            name: stop1TextController.value.text,
            originToStopFair: isStop1Added.value ? "10" : "",
            stopToStopFair:
                stop2TextController.value.text.isNotEmpty ? "20" : "",
            stopTodestinationFair: isStop1Added.value ? 30 : null),

        //? is stop 2 added?
        PostRideModelRidesDetailsStops(
            latitude: stop2Lat.value,
            longitude: stop2Long.value,
            name: stop2TextController.value.text,
            originToStopFair:
                stop2TextController.value.text.isNotEmpty ? "40" : "",
            stopTodestinationFair:
                stop2TextController.value.text.isNotEmpty ? 50 : null),
      ],
      // for trip type if tab index is 0 then one Time trip
      tripType: tripType.value,
      date: tabIndex.value == 1 ? "" : selectedDateOneTime.text,
      time: tabIndex.value == 1
          ? selectedRecurringTime.text
          : selectedTimeOneTime.text,
      recurringTrip:
          PostRideModelRidesDetailsRecurringTrip(recurringTripDays: daysOfWeek),
      seatAvailable: count.value,
      description: descriptionTextController.value.text,
      preferences: PostRideModelRidesDetailsPreferences(
          luggageType: selectedCHIP.value,
          other: PostRideModelRidesDetailsPreferencesOther(
            AppreciatesConversation: appreciatesConversation.value,
            EnjoysMusic: enjoysMusic.value,
            SmokeFree: smokeFree.value,
            PetFriendly: petFriendly.value,
            WinterTires: winterTires.value,
            CoolingOrHeating: coolingOrHeating.value,
            BabySeat: babySeat.value,
            HeatedSeats: heatedSeats.value,
          )),
      returnTrip: PostRideModelRidesDetailsReturnTrip(
        isReturnTrip: tabIndex.value != 1 ? isReturn.value : false,
        returnDate: tabIndex.value != 1 ? selectedDateReturnTrip.text : "",
        returnTime: tabIndex.value != 1 ? selectedTimeReturnTrip.text : "",
      ),
    ));
    try {
      final postRideDataJson = postRideData.toJson();
      await APIManager.postDriverPostRide(body: postRideDataJson);
      showMySnackbar(msg: "Ride posted successfully");
      await Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      throw Exception(e);
    }
  }

  String? fareValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Enter a reasonable cost';
    }

    // Check if the value is greater than 9999
    if (double.parse(value) > 9999.99) {
      return 'Cost exceeded';
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<ProfileController>().isSwitched.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<ProfileController>().isSwitched.value
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
        builder: (BuildContext context, Widget? child) {
          return Theme(
            // Define the custom theme for the date picker
            data: ThemeData(
              // Define the primary color
              primaryColor: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the color scheme for the date picker
              colorScheme: ColorScheme.light(
                // Define the primary color for the date picker
                primary: Get.find<ProfileController>().isSwitched.value
                    ? ColorUtil.kPrimaryPinkMode
                    : ColorUtil.kPrimary01,
                // Define the background color for the date picker
                surface: Colors.white,
                // Define the on-primary color for the date picker
                onPrimary: Colors.white,
                secondary: Get.find<ProfileController>().isSwitched.value
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
      String formattedDate = pickedDate.toIso8601String();
      selectedDateReturnTrip.text = formattedDate;
      formattedReturnDate.text =
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
            primaryColor: Get.find<ProfileController>().isSwitched.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<ProfileController>().isSwitched.value
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
      selectedTimeOneTime.text = formattedTime.toString();
    }
  }

  Future<void> setReturnTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<ProfileController>().isSwitched.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<ProfileController>().isSwitched.value
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
      selectedTimeReturnTrip.text = formattedTime.toString();
    }
  }

  Future<void> setRecurringTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<ProfileController>().isSwitched.value
                ? ColorUtil.kPrimaryPinkMode
                : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimaryPinkMode
                  : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<ProfileController>().isSwitched.value
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

  setActiveStatePostRideView() {
    if (originTextController.value.text.isNotEmpty &&
        destinationTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  setActive() async {
    if (await Get.toNamed(Routes.ORIGIN, arguments: LocationValues.origin)) {
      update();
    } else {}
  }

  setActiveStateCarpoolSchedule() {
    if (tabIndex.value == 0
        ? formattedOneTimeDate.value.text.isNotEmpty
        : daysOfWeek!.isNotEmpty) {
      isActiveCarpoolButton.value = true;
    } else {
      isActiveCarpoolButton.value = false;
    }
  }

  setActiveStatePricing() {
    String? validationResult = fareValidator(priceTextController.value.text);

    if (validationResult != null) {
      isActivePricingButton.value = false;
    } else {
      isActivePricingButton.value = true;
    }
  }

  void addDays(int heading) {
    daysOfWeek?.add(heading);
  }

  void removeDays(int heading) {
    daysOfWeek?.remove(heading);
  }
}

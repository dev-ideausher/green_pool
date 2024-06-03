import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../home/controllers/home_controller.dart';

class PostRideStepTwoController extends GetxController {
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  RxBool isPinkMode = Get.find<HomeController>().isPinkModeOn;
  RxInt tabIndex = 0.obs;
  TextEditingController selectedDateOneTime = TextEditingController();
  TextEditingController formattedOneTimeDate = TextEditingController();
  TextEditingController selectedTimeOneTime = TextEditingController();
  TextEditingController selectedDateReturnTrip = TextEditingController();
  TextEditingController formattedReturnDate = TextEditingController();
  TextEditingController selectedTimeReturnTrip = TextEditingController();
  TextEditingController selectedRecurringTime = TextEditingController();

  RxBool isReturn = false.obs;
  RxBool isActiveCarpoolButton = false.obs;
  final RxInt count = 1.obs;

  //for Days of week
  RxBool isMonday = false.obs;
  RxBool isTuesday = false.obs;
  RxBool isWednesday = false.obs;
  RxBool isThursDay = false.obs;
  RxBool isFriday = false.obs;
  RxBool isSaturday = false.obs;
  RxBool isSunday = false.obs;
  List<int?>? daysOfWeek = <int>[].obs;

  //luggage allowance
  RxBool noLuggage = false.obs;
  RxBool smallLuggage = false.obs;
  RxBool mediumLuggage = false.obs;
  RxBool largeLuggage = false.obs;
  RxString selectedCHIP = 'No'.obs;
  final RxString luggageWeight = 'No'.obs;

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
    final now = TimeOfDay.now();

    selectedTimeOneTime.text = TimeOfDay(hour: now.hour + 2, minute: 0).format(Get.context!).toString();
    final pickedDate = DateTime.now();
    selectedDateOneTime.text = pickedDate.toIso8601String();
    formattedOneTimeDate.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    postRideModel.value = Get.arguments;
    setActiveStateCarpoolSchedule();
  }

  void addDays(int heading) {
    daysOfWeek?.add(heading);
  }

  void removeDays(int heading) {
    daysOfWeek?.remove(heading);
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Define the custom theme for the date picker
          data: ThemeData(
            // Define the primary color
            primaryColor: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
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
      formattedOneTimeDate.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
            primaryColor: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
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

  Future<void> setReturnDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            // Define the custom theme for the date picker
            data: ThemeData(
              // Define the primary color
              primaryColor: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
              // Define the color scheme for the date picker
              colorScheme: ColorScheme.light(
                // Define the primary color for the date picker
                primary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
                // Define the background color for the date picker
                surface: Colors.white,
                // Define the on-primary color for the date picker
                onPrimary: Colors.white,
                secondary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
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
      formattedReturnDate.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
            primaryColor: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
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
            primaryColor: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
            // Define the color scheme for the date picker
            colorScheme: ColorScheme.light(
              // Define the primary color for the date picker
              primary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
              // Define the background color for the date picker
              surface: Colors.white,
              // Define the on-primary color for the date picker
              onPrimary: Colors.white,
              secondary: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
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

  setActiveStateCarpoolSchedule() {
    if (tabIndex.value == 0 ? formattedOneTimeDate.value.text.isNotEmpty : daysOfWeek!.isNotEmpty) {
      isActiveCarpoolButton.value = true;
    } else {
      isActiveCarpoolButton.value = false;
    }
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

  moveToPricingView() {
    Get.toNamed(Routes.POST_RIDE_STEP_THREE,
        arguments: PostRideModel(
          ridesDetails: PostRideModelRidesDetails(
            origin: PostRideModelRidesDetailsOrigin(
                name: postRideModel.value.ridesDetails?.origin?.name,
                latitude: postRideModel.value.ridesDetails?.origin?.latitude,
                longitude: postRideModel.value.ridesDetails?.origin?.longitude),
            destination: PostRideModelRidesDetailsDestination(
                name: postRideModel.value.ridesDetails?.destination?.name,
                latitude: postRideModel.value.ridesDetails?.destination?.latitude,
                longitude: postRideModel.value.ridesDetails?.destination?.longitude),
            stops: [
              PostRideModelRidesDetailsStops(
                  name: postRideModel.value.ridesDetails?.stops?[0]?.name,
                  latitude: postRideModel.value.ridesDetails?.stops?[0]?.latitude,
                  longitude: postRideModel.value.ridesDetails?.stops?[0]?.longitude),
              PostRideModelRidesDetailsStops(
                  name: postRideModel.value.ridesDetails?.stops?[1]?.name,
                  latitude: postRideModel.value.ridesDetails?.stops?[1]?.latitude,
                  longitude: postRideModel.value.ridesDetails?.stops?[1]?.longitude),
            ],
            tripType: tabIndex.value == 0 ? "oneTime" : "recurring",
            date: tabIndex.value == 1 ? "" : selectedDateOneTime.text,
            time: tabIndex.value == 1 ? selectedRecurringTime.text : selectedTimeOneTime.text,
            recurringTrip: PostRideModelRidesDetailsRecurringTrip(recurringTripDays: tabIndex.value == 1 ? daysOfWeek : []),
            seatAvailable: count.value,
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
          ),
        ));
  }
}

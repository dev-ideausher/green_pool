import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/ride_fare_model.dart';
import '../../../services/colors.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/gp_util.dart';
import '../../../utils/validation.dart';
import '../../home/controllers/home_controller.dart';

class MyRidesEditController extends GetxController {
  TextEditingController selectedDate = TextEditingController();
  TextEditingController formattedOneTimeDate = TextEditingController();
  TextEditingController selectedTime = TextEditingController();
  final RxInt seatCount = 1.obs;
  var editData = BookingDetailModelData().obs;

  //amenities
  RxBool appreciatesConversation = false.obs;
  RxBool enjoysMusic = false.obs;
  RxBool smokeFree = false.obs;
  RxBool petFriendly = false.obs;
  RxBool winterTires = false.obs;
  RxBool coolingOrHeating = false.obs;
  RxBool babySeat = false.obs;
  RxBool heatedSeats = false.obs;

  //luggage allowance
  RxBool noLuggage = false.obs;
  RxBool smallLuggage = false.obs;
  RxBool mediumLuggage = false.obs;
  RxBool largeLuggage = false.obs;
  RxString selectedCHIP = 'No'.obs;
  final RxString luggageWeight = 'No'.obs;

  //pricing
  RxBool viewPrice = false.obs;
  RxBool isLoading = true.obs;
  RxDouble maxFarePrice = 0.0.obs;
  RxDouble minFarePrice = 0.0.obs;
  num totalDistance =
      0; //need to add this data and stops data to myRidesModel from backend
  RxBool isActivePricingButton = false.obs;

  var orToDestPrice = TextEditingController();
  var originToStop1Price = TextEditingController();
  var originToStop2Price = TextEditingController();
  var stop1ToStop2Price = TextEditingController();
  var stop1ToDestinationPrice = TextEditingController();
  var stop2toDestinationPrice = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    editData.value = Get.arguments;
    _setExistingDateTime();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void _setExistingDateTime() {
    final data = editData.value.driverBookingDetails;
    DateTime date = DateTime.parse(data?.date ?? "");
    selectedDate.text = date.toIso8601String();
    formattedOneTimeDate.text = "${date.day}/${date.month}/${date.year}";

    selectedTime.text = DateTimeUtils.convertUtcToLocal(data?.time ?? "");

    seatCount.value = data?.seatAvailable ?? 1;

    luggageWeight.value = data?.preferences?.luggageType ?? "No";

    appreciatesConversation.value =
        data?.preferences?.other?.AppreciatesConversation ?? false;
    enjoysMusic.value = data?.preferences?.other?.EnjoysMusic ?? false;
    smokeFree.value = data?.preferences?.other?.SmokeFree ?? false;
    petFriendly.value = data?.preferences?.other?.PetFriendly ?? false;
    winterTires.value = data?.preferences?.other?.WinterTires ?? false;
    coolingOrHeating.value =
        data?.preferences?.other?.CoolingOrHeating ?? false;
    babySeat.value = data?.preferences?.other?.BabySeat ?? false;
    heatedSeats.value = data?.preferences?.other?.HeatedSeats ?? false;

    orToDestPrice.text = data?.origin?.originDestinationFair ?? "";

    if (data?.stops?.first?.name?.isNotEmpty ?? false) {
      //if stop 1 added
      originToStop1Price.text =
          data?.stops?[0]?.originToStopFair?.toString() ?? "";
      stop1ToStop2Price.text =
          data?.stops?[0]?.stopToStopFair?.toString() ?? "";
      stop1ToDestinationPrice.text =
          data?.stops?[0]?.stopTodestinationFair?.toString() ?? "";
      if (data?.stops?[1]?.name?.isNotEmpty ?? false) {
        //if stop 2 added
        originToStop2Price.text =
            data?.stops?[1]?.originToStopFair?.toString() ?? "";
        stop2toDestinationPrice.text =
            data?.stops?[1]?.stopTodestinationFair?.toString() ?? "";
      }
    }

    getRideFareAPI();
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = Platform.isIOS
        ? await DialogHelper.cupertinoDatePicker(context, DateTime.now(),
            DateTime.now().add(const Duration(days: 3 * 30)), DateTime.now())
        : await showDatePicker(
            context: context,
            builder: _pickerTheme,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 3 * 30)),
            initialDate: DateTime.now(),
          );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toIso8601String();
      selectedDate.text = formattedDate;
      selectedTime.clear();
      formattedOneTimeDate.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<void> setTime(BuildContext context) async {
    TimeOfDay? pickedTime = Platform.isIOS
        ? await DialogHelper.cupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            builder: _pickerTheme,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );
    if (pickedTime != null) {
      // Use MaterialLocalizations to format the time in 24-hour format
      final MaterialLocalizations localizations =
          MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(pickedTime,
          alwaysUse24HourFormat: false);

      if (selectedDate.text.isNotEmpty) {
        if (DateTimeUtils.isToday(DateTime.parse(selectedDate.text))) {
          if (DateTimeUtils.isAfterCurrentTime(formattedTime)) {
            selectedTime.text = formattedTime;
          } else {
            showMySnackbar(msg: "Please select a valid time");
            selectedTime.clear();
          }
        } else {
          selectedTime.text = formattedTime;
        }
      } else {
        showMySnackbar(msg: "Please select a date");
      }
    }
  }

  void increment() {
    //handles available seat number
    if (seatCount.value <= 9) {
      seatCount.value++;
    }
  }

  void decrement() {
    //handles available seat number
    if (seatCount.value >= 2) {
      seatCount.value--;
    }
  }

  void setLuggageWeight(String s) {
    if (selectedCHIP.value == "No") {
      luggageWeight.value = "No";
    } else if (selectedCHIP.value == "S") {
      luggageWeight.value = "5 kg";
    } else if (selectedCHIP.value == "M") {
      luggageWeight.value = "10 kg";
    } else if (selectedCHIP.value == "L") {
      luggageWeight.value = "15 kg";
    }
  }

  //set prices

  getRideFareAPI() async {
    //to set price from origin to destination
    final data = editData.value.driverBookingDetails;
    try {
      totalDistance = GpUtil.calculateDistance(
          startLat: data?.origin?.coordinates?.last ?? 0.0,
          startLong: data?.origin?.coordinates?.first ?? 0.0,
          endLat: data?.destination?.coordinates?.last ?? 0.0,
          endLong: data?.destination?.coordinates?.first ?? 0.0);

      final response =
          await APIManager.getRideFare(distance: totalDistance.round());
      final rideFareModel = RideFareModel.fromJson(response.data);
      maxFarePrice.value = rideFareModel.data!.maxPrice!;
      minFarePrice.value = rideFareModel.data!.minPrice!;

      if (double.parse(orToDestPrice.text) < minFarePrice.value ||
          double.parse(orToDestPrice.text) > maxFarePrice.value) {
        orToDestPrice.text = minFarePrice.round().toString();
      }

      if (data?.stops?.first?.name?.isNotEmpty ?? false) {
        await createPrice();
        (orToDestPrice.text.isNotEmpty)
            ? isActivePricingButton.value = true
            : isActivePricingButton.value = false;
      } else {
        isActivePricingButton.value = true;
      }
    } catch (e) {
      debugPrint("get fare api error: $e");
    }
  }

  setActiveStatePricing() async {
    String? validationResult = fareValidator(
        value: orToDestPrice.value.text,
        maxFarePrice: maxFarePrice.value,
        minFarePrice: minFarePrice.value);

    if (validationResult != null) {
      isActivePricingButton.value = false;
      return;
    } else {
      if (editData.value.driverBookingDetails?.stops?.isNotEmpty ?? false) {
        if (editData
                .value.driverBookingDetails?.stops?.first?.name?.isNotEmpty ??
            false) {
          await createPrice();
          (orToDestPrice.text.isNotEmpty)
              ? isActivePricingButton.value = true
              : isActivePricingButton.value = false;
        } else {
          isActivePricingButton.value = true;
        }
      } else {
        isActivePricingButton.value = true;
      }
    }
  }

  Future<void> createPrice() async {
    try {
      isActivePricingButton.value = false;
      final totalPriceValue = int.tryParse(orToDestPrice.text) ?? 0;

      if (totalPriceValue <= 0) {
        debugPrint("Invalid total price value.");
        return;
      }

      final ratePerKm = calculateRatePerKm(
          totalDistance: totalDistance, totalPrice: totalPriceValue);

      final rideDetails = editData.value.driverBookingDetails;
      if (rideDetails == null) {
        debugPrint("Ride details not available.");
        return;
      }

      final origin = rideDetails.origin;
      final destination = rideDetails.destination;
      final stops = rideDetails.stops ?? [];

      if (stops.isNotEmpty && stops.first?.name?.isNotEmpty == true) {
        //origin to stop1
        await _calculateAndSetPrice(
            startLat: origin?.coordinates?.last ?? 0.0,
            startLong: origin?.coordinates?.first ?? 0.0,
            endLat: stops.first?.coordinates?.last ?? 0.0,
            endLong: stops.first?.coordinates?.first ?? 0.0,
            priceField: originToStop1Price,
            ratePerKm: ratePerKm);

        //stop1 to destination
        await _calculateAndSetPrice(
            startLat: stops.first?.coordinates?.last ?? 0.0,
            startLong: stops.first?.coordinates?.first ?? 0.0,
            endLat: destination?.coordinates?.last ?? 0.0,
            endLong: destination?.coordinates?.first ?? 0.0,
            priceField: stop1ToDestinationPrice,
            ratePerKm: ratePerKm);
      }

      if (stops.length > 1 && stops[1]?.name?.isNotEmpty == true) {
        //origin to stop2
        await _calculateAndSetPrice(
            startLat: origin?.coordinates?.last ?? 0.0,
            startLong: origin?.coordinates?.first ?? 0.0,
            endLat: stops[1]?.coordinates?.last ?? 0.0,
            endLong: stops[1]?.coordinates?.first ?? 0.0,
            priceField: originToStop2Price,
            ratePerKm: ratePerKm);

        //stop1 to stop2
        await _calculateAndSetPrice(
            startLat: stops.first?.coordinates?.last ?? 0.0,
            startLong: stops.first?.coordinates?.first ?? 0.0,
            endLat: stops[1]?.coordinates?.last ?? 0.0,
            endLong: stops[1]?.coordinates?.first ?? 0.0,
            priceField: stop1ToStop2Price,
            ratePerKm: ratePerKm);

        //stop2 to destination
        await _calculateAndSetPrice(
            startLat: stops[1]?.coordinates?.last ?? 0.0,
            startLong: stops[1]?.coordinates?.first ?? 0.0,
            endLat: destination?.coordinates?.last ?? 0.0,
            endLong: destination?.coordinates?.first ?? 0.0,
            priceField: stop2toDestinationPrice,
            ratePerKm: ratePerKm);
      }
    } catch (e) {
      debugPrint("Error in createPrice: $e");
    }
  }

  /// Calculates distance and sets price, ensuring a minimum of 5 dollars.
  Future<void> _calculateAndSetPrice(
      {required double? startLat,
      required double? startLong,
      required double? endLat,
      required double? endLong,
      required TextEditingController priceField,
      required double ratePerKm}) async {
    if (startLat == null ||
        startLong == null ||
        endLat == null ||
        endLong == null) {
      debugPrint("Invalid coordinates, skipping distance calculation.");
      return;
    }

    final distance = GpUtil.calculateDistance(
        startLat: startLat,
        startLong: startLong,
        endLat: endLat,
        endLong: endLong);

    final price = (distance * ratePerKm).round();
    priceField.text = price < 5 ? "5" : price.toString();
  }

  double calculateRatePerKm(
      {required num totalDistance, required num totalPrice}) {
    if (totalDistance <= 0) {
      return 1;
    }
    return (totalPrice / totalDistance);
  }

  void onFareChanged(String? value) {
    final debouncer = Debouncer(delay: const Duration(milliseconds: 50));
    if (value != null &&
        value.isNotEmpty &&
        value != "0" &&
        double.parse(value) < maxFarePrice.value &&
        double.parse(value) > minFarePrice.value) {
      debouncer(() {
        setActiveStatePricing();
      });
    }
  }

  void saveChanges() async {
    final combinedDateTime =
        "${selectedDate.text.toString().split("T").first}T${selectedTime.text}";

    final combinedDateTimeUTC =
        DateTimeUtils.convertCombinedToGmt(combinedDateTime);

    final String date = combinedDateTimeUTC.split("T").first;
    final String time = combinedDateTimeUTC;

    final body = {
      "date": date,
      "time": time,
      "seatAvailable": seatCount.value,
      "origin": {"originDestinationFair": orToDestPrice.value.text},
      "stops": [
        {
          "originToStopFair": originToStop1Price.value.text,
          "stopToStopFair": stop1ToStop2Price.value.text,
          "stopTodestinationFair": stop1ToDestinationPrice.value.text
        },
        {
          "originToStopFair": originToStop2Price.value.text,
          "stopToStopFair": stop1ToStop2Price.value.text,
          "stopTodestinationFair": stop2toDestinationPrice.value.text
        }
      ],
      "preferences": {
        "luggageType": luggageWeight.value,
        "other": {
          "AppreciatesConversation": appreciatesConversation.value,
          "EnjoysMusic": enjoysMusic.value,
          "SmokeFree": smokeFree.value,
          "PetFriendly": petFriendly.value,
          "WinterTires": winterTires.value,
          "CoolingOrHeating": coolingOrHeating.value,
          "BabySeat": babySeat.value,
          "HeatedSeats": heatedSeats.value
        }
      }
    };

    try {
      final res = await APIManager.putEditRide(
          driverRideId: editData.value.driverRideId ?? "", body: body);
      if (res.data['status']) {
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        showMySnackbar(msg: LocaleKeys.app_rideUpdated.tr);
      } else {
        showMySnackbar(msg: LocaleKeys.app_pleaseTryAgain.tr);
      }
    } catch (e) {
      showMySnackbar(msg: LocaleKeys.app_pleaseTryAgain.tr);
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Widget _pickerTheme(BuildContext context, Widget? child) {
    final setColor = Get.find<HomeController>().isPinkModeOn.value
        ? ColorUtil.kPrimaryPinkMode
        : ColorUtil.kPrimary01;
    return Theme(
      data: ThemeData(
        primaryColor: setColor,
        colorScheme: ColorScheme.light(
          primary: setColor,
          surface: Colors.white,
          onPrimary: Colors.white,
          secondary: setColor,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: child!,
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}

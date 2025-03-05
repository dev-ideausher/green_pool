import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/utils/gp_util.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../data/ride_fare_model.dart';
import '../../../routes/app_pages.dart';

class PostRideStepThreeController extends GetxController {
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  TextEditingController totalPrice = TextEditingController();
  TextEditingController originToStop1Price = TextEditingController();
  TextEditingController originToStop2Price = TextEditingController();
  TextEditingController stop1ToStop2Price = TextEditingController();
  TextEditingController stop1ToDestinationPrice = TextEditingController();
  TextEditingController stop2toDestinationPrice = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  RxBool isActivePricingButton = false.obs;
  RxBool viewPrice = false.obs;
  RxBool isLoading = true.obs;
  double maxFarePrice = 0.0;
  double minFarePrice = 0.0;

  num totalDistance = 0;
  var prevRideData = PostRideModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    postRideModel.value = Get.arguments;
    await getRideFareAPI();
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  getRideFareAPI() async {
    //to set price from origin to destination
    try {
      totalDistance = await GpUtil.calculateDistanceInInt(
          startLat: postRideModel.value.ridesDetails?.origin?.latitude ?? 0.0,
          startLong: postRideModel.value.ridesDetails?.origin?.longitude ?? 0.0,
          endLat:
              postRideModel.value.ridesDetails?.destination?.latitude ?? 0.0,
          endLong:
              postRideModel.value.ridesDetails?.destination?.longitude ?? 0.0);

      final response =
          await APIManager.getRideFare(distance: totalDistance.round());
      final rideFareModel = RideFareModel.fromJson(response.data);
      maxFarePrice = rideFareModel.data!.maxPrice!;
      minFarePrice = rideFareModel.data!.minPrice!;

      //?set values of prices and pink mode
      postRideModel.value.ridesDetails?.pinkMode =
          Get.find<GetStorageService>().isPinkMode;
      totalPrice.text = minFarePrice.round().toString();

      if (postRideModel.value.ridesDetails?.stops?.first.name?.isNotEmpty ??
          false) {
        await createPrice();
        (totalPrice.text.isNotEmpty)
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
    String? validationResult = fareValidator(totalPrice.value.text);

    if (validationResult != null) {
      isActivePricingButton.value = false;
    } else {
      if (postRideModel.value.ridesDetails?.stops?.isNotEmpty ?? false) {
        if (postRideModel.value.ridesDetails?.stops?.first.name?.isNotEmpty ??
            false) {
          await createPrice();
          (totalPrice.text.isNotEmpty)
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

  String? fareValidator(String? value) {
    // Check if the value is empty or contains invalid characters
    if (value == null ||
        value.isEmpty ||
        value == "," ||
        value == "." ||
        value == " " ||
        value == "-") {
      return 'Enter a pricing';
    }

    // Parse the value to a double
    double? parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      return 'Enter a valid pricing';
    }

    // Check if the value is greater than maxFarePrice
    if (parsedValue > (maxFarePrice ?? double.infinity)) {
      return 'Cost exceeded';
    }

    // Check if the value is less than minFarePrice
    if (parsedValue < (minFarePrice ?? double.negativeInfinity)) {
      return 'Cost under limit';
    }

    // Check if the value contains a decimal point
    if (value.contains('.')) {
      return 'Decimal not allowed';
    }

    // Check if the value is a valid number format without decimals
    final RegExp phoneExp = RegExp(r'^\d{1,4}$');

    if (!phoneExp.hasMatch(value)) {
      return 'Enter a valid pricing';
    }

    return null;
  }

  moveToGuidelines() {
    postRideModel.value.ridesDetails?.origin?.originDestinationFair =
        totalPrice.text;
    if (postRideModel.value.ridesDetails?.stops?.isNotEmpty ?? false) {
      postRideModel.value.ridesDetails?.stops?.first.originToStopFair =
          originToStop1Price.text;
      postRideModel.value.ridesDetails?.stops?.first.stopTodestinationFair =
          stop1ToDestinationPrice.text;
      postRideModel.value.ridesDetails?.stops?.first.stopToStopFair =
          stop1ToStop2Price.text;
      if (postRideModel.value.ridesDetails?.stops?.length == 2) {
        postRideModel.value.ridesDetails?.stops?[1].originToStopFair =
            originToStop2Price.text;
        postRideModel.value.ridesDetails?.stops?[1].stopTodestinationFair =
            stop2toDestinationPrice.text;
        postRideModel.value.ridesDetails?.stops?[1].stopToStopFair =
            stop1ToStop2Price.text;
      }
    }

    Get.toNamed(Routes.POST_RIDE_STEP_FOUR, arguments: postRideModel.value);
  }

  Future<void> createPrice() async {
    try {
      isActivePricingButton.value = false;
      final totalPriceValue = int.tryParse(totalPrice.text) ?? 0;

      if (totalPriceValue <= 0) {
        debugPrint("Invalid total price value.");
        return;
      }

      final ratePerKm = calculateRatePerKm(
          totalDistance: totalDistance, totalPrice: totalPriceValue);

      final rideDetails = postRideModel.value.ridesDetails;
      if (rideDetails == null) {
        debugPrint("Ride details not available.");
        return;
      }

      final origin = rideDetails.origin;
      final destination = rideDetails.destination;
      final stops = rideDetails.stops ?? [];

      if (stops.isNotEmpty && stops.first.name?.isNotEmpty == true) {
        //origin to stop1
        await _calculateAndSetPrice(
            startLat: origin?.latitude,
            startLong: origin?.longitude,
            endLat: stops.first.latitude,
            endLong: stops.first.longitude,
            priceField: originToStop1Price,
            ratePerKm: ratePerKm);

        //stop1 to destination
        await _calculateAndSetPrice(
            startLat: stops.first.latitude,
            startLong: stops.first.longitude,
            endLat: destination?.latitude,
            endLong: destination?.longitude,
            priceField: stop1ToDestinationPrice,
            ratePerKm: ratePerKm);
      }

      if (stops.length > 1 && stops[1].name?.isNotEmpty == true) {
        //origin to stop2
        await _calculateAndSetPrice(
            startLat: origin?.latitude,
            startLong: origin?.longitude,
            endLat: stops[1].latitude,
            endLong: stops[1].longitude,
            priceField: originToStop2Price,
            ratePerKm: ratePerKm);

        //stop1 to stop2
        await _calculateAndSetPrice(
            startLat: stops.first.latitude,
            startLong: stops.first.longitude,
            endLat: stops[1].latitude,
            endLong: stops[1].longitude,
            priceField: stop1ToStop2Price,
            ratePerKm: ratePerKm);

        //stop2 to destination
        await _calculateAndSetPrice(
            startLat: stops[1].latitude,
            startLong: stops[1].longitude,
            endLat: destination?.latitude,
            endLong: destination?.longitude,
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

    final distance = await GpUtil.calculateDistanceInInt(
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

  void onchanged(String? val) {
    if (val != null &&
        val.isNotEmpty &&
        val != "0" &&
        double.parse(val) < maxFarePrice &&
        double.parse(val) > minFarePrice) {
      postRideModel.value.ridesDetails?.origin?.originDestinationFair = val;
      setActiveStatePricing();
    }
  }

  setPrevRideData() {
    final prevRide = Get.find<GetStorageService>().getPostRideData();
    prevRideData.value = prevRide ?? PostRideModel();
    final rideDetails = prevRideData.value.ridesDetails;
    final stops = rideDetails?.stops ?? [];
    final fareString = rideDetails?.origin?.originDestinationFair ?? "0";
    final fare = double.tryParse(fareString) ?? 0.0;

    if (fare > minFarePrice && fare < maxFarePrice) {
      totalPrice.text = fare.toString();
    }

    if (stops.isNotEmpty && stops.first.name?.isNotEmpty == true) {
      originToStop1Price.text = stops.first.originToStopFair ?? "5";
      stop1ToDestinationPrice.text = stops.first.stopTodestinationFair ?? "5";
    }

    if (stops.length > 1 && stops[1].name?.isNotEmpty == true) {
      originToStop2Price.text = stops[1].originToStopFair ?? "5";
      stop1ToStop2Price.text = stops[1].stopToStopFair ?? "5";
      stop2toDestinationPrice.text = stops[1].stopTodestinationFair ?? "5";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/gp_util.dart';
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

  @override
  Future<void> onInit() async {
    super.onInit();
    postRideModel.value = Get.arguments;
    await getRideFareAPI();
    isLoading.value = false;
  }

  @override
  void onClose() {
    // totalPrice.dispose();
    // originToStop1Price.dispose();
    // originToStop2Price.dispose();
    // stop1ToStop2Price.dispose();
    // stop1ToDestinationPrice.dispose();
    // stop2toDestinationPrice.dispose();
    // descriptionTextController.dispose();
    super.onClose();
  }

  getRideFareAPI() async {
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
      final ratePerKm = calculateRatePerKm(
          totalDistance: totalDistance, totalPrice: int.parse(totalPrice.text));
      if (postRideModel.value.ridesDetails?.stops?.first.name?.isNotEmpty ??
          false) {
        final originToStop1Distance = await GpUtil.calculateDistanceInInt(
            startLat: postRideModel.value.ridesDetails?.origin?.latitude ?? 0.0,
            startLong:
                postRideModel.value.ridesDetails?.origin?.longitude ?? 0.0,
            endLat:
                postRideModel.value.ridesDetails?.stops?.first.latitude ?? 0.0,
            endLong: postRideModel.value.ridesDetails?.stops?.first.longitude ??
                0.0);
        originToStop1Price.text =
            (originToStop1Distance * ratePerKm).round().toString();

        //price should not go less than 5 dollars
        if (int.parse(originToStop1Price.text) < 5) {
          originToStop1Price.text = "5";
        }

        final stop1toDestinationDistance = await GpUtil.calculateDistanceInInt(
            startLat:
                postRideModel.value.ridesDetails?.stops?.first.latitude ?? 0.0,
            startLong:
                postRideModel.value.ridesDetails?.stops?.first.longitude ?? 0.0,
            endLat:
                postRideModel.value.ridesDetails?.destination?.latitude ?? 0.0,
            endLong: postRideModel.value.ridesDetails?.destination?.longitude ??
                0.0);
        stop1ToDestinationPrice.text =
            (stop1toDestinationDistance * ratePerKm).round().toString();

        //price should not go less than 5 dollars
        if (int.parse(stop1ToDestinationPrice.text) < 5) {
          stop1ToDestinationPrice.text = "5";
        }

        if (postRideModel.value.ridesDetails?.stops?[1].name?.isNotEmpty ??
            false) {
          final originToStop2Distance = await GpUtil.calculateDistanceInInt(
              startLat:
                  postRideModel.value.ridesDetails?.origin?.latitude ?? 0.0,
              startLong:
                  postRideModel.value.ridesDetails?.origin?.longitude ?? 0.0,
              endLat:
                  postRideModel.value.ridesDetails?.stops?[1].latitude ?? 0.0,
              endLong:
                  postRideModel.value.ridesDetails?.stops?[1].longitude ?? 0.0);
          final stop1toStop2Distance = await GpUtil.calculateDistanceInInt(
              startLat:
                  postRideModel.value.ridesDetails?.origin?.latitude ?? 0.0,
              startLong:
                  postRideModel.value.ridesDetails?.origin?.longitude ?? 0.0,
              endLat:
                  postRideModel.value.ridesDetails?.stops?[1].latitude ?? 0.0,
              endLong:
                  postRideModel.value.ridesDetails?.stops?[1].longitude ?? 0.0);

          final stop2toDestinationDistance =
              await GpUtil.calculateDistanceInInt(
                  startLat:
                      postRideModel.value.ridesDetails?.stops?[1].latitude ??
                          0.0,
                  startLong:
                      postRideModel.value.ridesDetails?.stops?[1].longitude ??
                          0.0,
                  endLat:
                      postRideModel.value.ridesDetails?.destination?.latitude ??
                          0.0,
                  endLong: postRideModel
                          .value.ridesDetails?.destination?.longitude ??
                      0.0);

          originToStop2Price.text =
              (originToStop2Distance * ratePerKm).round().toString();
          stop1ToStop2Price.text =
              (stop1toStop2Distance * ratePerKm).round().toString();
          stop2toDestinationPrice.text =
              (stop2toDestinationDistance * ratePerKm).round().toString();

          //price should not go less than 5 dollars
          if (int.parse(originToStop2Price.text) < 5) {
            originToStop2Price.text = "5";
          }
          if (int.parse(stop1ToStop2Price.text) < 5) {
            stop1ToStop2Price.text = "5";
          }
          if (int.parse(stop2toDestinationPrice.text) < 5) {
            stop2toDestinationPrice.text = "5";
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setActiveStatePricing();
  }

  double calculateRatePerKm(
      {required num totalDistance, required num totalPrice}) {
    if (totalDistance <= 0) {
      return 1;
    }
    return (totalPrice / totalDistance);
  }
}

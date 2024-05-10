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
  TextEditingController OriginToStop2Price = TextEditingController();
  TextEditingController Stop1ToStop2Price = TextEditingController();
  TextEditingController Stop1ToDestinationPrice = TextEditingController();
  TextEditingController Stop2toDestinationPrice = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  var rideFareModel = RideFareModel().obs;

  RxBool isActivePricingButton = false.obs;
  RxBool viewPrice = false.obs;
  RxBool isLoading = false.obs;

  final String distance = "100";
  // final String totalDistance = GpUtil.calculateDistance(startLat: postRideModel.value.ridesDetails?.origin?.latitude, startLong: startLong, endLat: endLat, endLong: endLong).toStringAsFixed(2);
  final String originToStop1Distance = "100";
  final String OriginToStop2Distance = "100";
  final String Stop1ToStop2Distance = "100";
  final String Stop1ToDestinationDistance = "100";
  final String Stop2toDestinationDistance = "100";

  double? maxFarePrice;
  double? minFarePrice;

  double? originToStop1;
  double? OriginToStop2;
  double? Stop1ToStop2;
  double? Stop1ToDestination;
  double? Stop2toDestination;

  @override
  void onInit() {
    super.onInit();
    postRideModel.value = Get.arguments;
    getRideFareAPI();
  }

  getRideFareAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getRideFare(
          distance: GpUtil.calculateDistance(
                  startLat:
                      postRideModel.value.ridesDetails?.origin?.latitude ?? 0.0,
                  startLong:
                      postRideModel.value.ridesDetails?.origin?.longitude ??
                          0.0,
                  endLat:
                      postRideModel.value.ridesDetails?.destination?.latitude ??
                          0.0,
                  endLong: postRideModel
                          .value.ridesDetails?.destination?.longitude ??
                      0.0)
              .toStringAsFixed(2));
      rideFareModel.value = RideFareModel.fromJson(response.data);
      maxFarePrice = rideFareModel.value.data!.maxPrice!;
      minFarePrice = rideFareModel.value.data!.minPrice!;
      isLoading.value = false;
      //?set values of prices and pink mode
      postRideModel.value.ridesDetails?.pinkMode =
          Get.find<GetStorageService>().isPinkMode;
      /*postRideModel.value.ridesDetails?.stops?[0]?.originToStopFair =
        originToStop1Price.value.text;
    postRideModel.value.ridesDetails?.stops?[0]?.stopTodestinationFair =
        int.parse(Stop1ToDestinationPrice.value.text ?? "0");
    postRideModel.value.ridesDetails?.stops?[0]?.stopToStopFair =
        Stop1ToStop2Price.value.text;
    postRideModel.value.ridesDetails?.stops?[1]?.originToStopFair =
        OriginToStop2Price.value.text;
    postRideModel.value.ridesDetails?.stops?[1]?.stopTodestinationFair =
        int.parse(Stop2toDestinationPrice.value.text ?? '0');*/
    } catch (e) {
      debugPrint("get fare api error: $e");
    }
  }

  setActiveStatePricing() {
    String? validationResult = fareValidator(totalPrice.value.text);

    if (validationResult != null) {
      isActivePricingButton.value = false;
    } else {
      isActivePricingButton.value = true;
    }
  }

  String? fareValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty || value == ",") {
      return 'Enter a pricing';
    }

    // Check if the value is greater than 9999
    if (double.parse(value) > maxFarePrice!) {
      return 'Cost exceeded';
    }

    if (double.parse(value) < minFarePrice!) {
      return 'Cost under limit';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^\d{1,4}\.?\d{0,2}$');

    if (!phoneExp.hasMatch(value)) {
      return 'Enter a pricing';
    }

    return null; // Return null if the value is valid
  }

  moveToGuidelines() {
    Get.toNamed(Routes.POST_RIDE_STEP_FOUR, arguments: postRideModel.value);
  }
}

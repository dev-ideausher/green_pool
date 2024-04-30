import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../data/ride_fare_model.dart';

class PostRideStepThreeController extends GetxController {
  TextEditingController priceTextController = TextEditingController();
  TextEditingController price2TextController = TextEditingController();
  TextEditingController price3TextController = TextEditingController();
  TextEditingController price4TextController = TextEditingController();
  TextEditingController price5TextController = TextEditingController();
  TextEditingController price6TextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  var rideFareModel = RideFareModel().obs;

  RxBool isActivePricingButton = false.obs;
  RxBool viewPrice = false.obs;
  RxBool isLoading = false.obs;

  final String distance = "100";

  double? maxFarePrice;
  double? minFarePrice;

  @override
  void onInit() {
    super.onInit();
    getRideFareAPI();
  }

  getRideFareAPI() async {
    isLoading.value = true;
    final response = await APIManager.getRideFare(distance: distance);
    rideFareModel.value = RideFareModel.fromJson(response.data);
    maxFarePrice = rideFareModel.value.data!.maxPrice! * double.parse(distance);
    minFarePrice = rideFareModel.value.data!.minPrice! * double.parse(distance);
    isLoading.value = false;
  }

  setActiveStatePricing() {
    String? validationResult = fareValidator(priceTextController.value.text);

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
}

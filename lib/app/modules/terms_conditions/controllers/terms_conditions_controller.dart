import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

class TermsConditionsController extends GetxController {
  RxBool isLoading = false.obs;
  String termsText = '';

  @override
  void onInit() {
    super.onInit();
    termsConditionsAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  termsConditionsAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getCompanyDetails();
      if (response.data["status"]) {
        termsText = response.data['data'][0]['termsAndContions'].toString();
      } else {
        showMySnackbar(msg: response.data["message"].toString());
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

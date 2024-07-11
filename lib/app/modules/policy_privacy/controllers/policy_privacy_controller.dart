import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../services/dio/api_service.dart';

class PolicyPrivacyController extends GetxController {
  RxBool isLoading = false.obs;
  String policyText = '';

  @override
  void onInit() {
    super.onInit();
    privacyPolicyAPI();
  }

  privacyPolicyAPI() async {
    try {
      isLoading.value = true;
      // final response = await APIManager.getPrivacyPolicy();
      final response = await APIManager.getGuidelines();
      if (response.data["status"]) {
        policyText = response.data['data'][0]['description'].toString();
      } else {
        showMySnackbar(msg: response.data['message']);
      }
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

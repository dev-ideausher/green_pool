import 'package:get/get.dart';

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
    isLoading.value = true;
    final response = await APIManager.getPrivacyPolicy();
    policyText = response.data['data'][0]['description'].toString();
    isLoading.value = false;
  }
}

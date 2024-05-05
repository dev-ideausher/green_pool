import 'package:get/get.dart';

import '../../../services/dio/api_service.dart';

class PolicyCancellationController extends GetxController {
  RxBool isLoading = false.obs;
  String policyText = '';

  @override
  void onInit() {
    super.onInit();
    driverCancellationPolicyAPI();
  }

  driverCancellationPolicyAPI() async {
    isLoading.value = true;
    final response = await APIManager.getCancelRefundPolicy();
    policyText = response.data['data'][0]['description'].toString();
    isLoading.value = false;
  }
}

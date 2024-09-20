import 'package:get/get.dart';

class PolicyCancellationController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoad = false.obs;
  String policyText = '';

  @override
  void onInit() {
    super.onInit();
  }

  /*driverCancellationPolicyAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getCancelRefundPolicy();
      policyText = response.data['data'][0]['description'].toString();
      isLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }*/
}

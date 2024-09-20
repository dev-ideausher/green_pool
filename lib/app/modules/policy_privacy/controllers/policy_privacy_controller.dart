import 'package:get/get.dart';

class PolicyPrivacyController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoad = false.obs;
  String policyText = '';

  @override
  void onInit() {
    super.onInit();
  }

  /*privacyPolicyAPI() async {
    try {
      isLoading.value = true;
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
  }*/
}

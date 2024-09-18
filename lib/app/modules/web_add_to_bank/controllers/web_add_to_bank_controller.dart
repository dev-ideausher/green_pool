import 'package:get/get.dart';

class WebAddToBankController extends GetxController {
  String stripeRedirectUrl = "";
  RxBool isLoading = true.obs;
  RxBool isPageLoaded = true.obs;

  @override
  void onInit() {
    super.onInit();
    stripeRedirectUrl = Get.arguments;
    isLoading.value = false;
  }

  /*@override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }*/
}

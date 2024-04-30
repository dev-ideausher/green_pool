import 'package:get/get.dart';

class VerificationDoneController extends GetxController {
  bool fromNavBar = false;
  bool isDriver = false;

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments['isDriver'];
    fromNavBar = Get.arguments['fromNavBar'];
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

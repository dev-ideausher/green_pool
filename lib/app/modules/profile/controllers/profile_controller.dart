import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isSwitched = false.obs;

  bool toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    return isSwitched.value;
  }
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isOldPassVisible = false.obs;
  RxBool isNewPassVisible = false.obs;
  RxBool isConfirmPassVisible = false.obs;

  setOldVisible() {
    isOldPassVisible.toggle();
  }

  setNewVisible() {
    isNewPassVisible.toggle();
  }

  setConfirmVisible() {
    isConfirmPassVisible.toggle();
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

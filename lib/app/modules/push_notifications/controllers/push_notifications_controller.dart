import 'package:get/get.dart';

class PushNotificationsController extends GetxController {
  List<RxBool> isChecked = List.generate(12, (index) => false.obs);

  void setChecked(int index) {
    isChecked[index].value = !isChecked[index].value;
  }

  // final count = 0.obs;
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

  // void increment() => count.value++;
}

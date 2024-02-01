import 'package:get/get.dart';

class RiderFilterController extends GetxController {
  List<RxBool> isChecked = List.generate(12, (index) => false.obs);

  void toggleSwitch(int index) {
    isChecked[index].value = !isChecked[index].value;
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

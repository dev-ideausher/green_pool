import 'package:get/get.dart';

import '../../../services/storage.dart';

class MyRidesController extends GetxController {
  RxBool mapViewType = false.obs;
  RxBool isDriver = Get.find<GetStorageService>().isDriver.obs;

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
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

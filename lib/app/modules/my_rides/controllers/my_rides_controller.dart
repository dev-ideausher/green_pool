import 'package:get/get.dart';

import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';

class MyRidesController extends GetxController {
  RxBool mapViewType = false.obs;
  RxBool isDriver = Get.find<GetStorageService>().isDriver.obs;
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;

  void changeViewType() {
    mapViewType.value = !mapViewType.value;
    print(latitude);
    print(longitude);
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

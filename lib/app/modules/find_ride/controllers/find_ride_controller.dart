import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class FindRideController extends GetxController {
  bool isDriver = false;

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  decideRouting() {
    if (Get.find<GetStorageService>().getLoggedIn) {
      Get.toNamed(Routes.MATCHING_RIDES, arguments: isDriver);
    }
    //  else if (Get.find<GetStorageService>().getLoggedIn &&  Get.find<HomeController>().isDriver.value) {
    //     Get.off(const CarpoolScheduleView());
    //   }
    else if (!Get.find<GetStorageService>().getLoggedIn) {
      Get.offNamed(Routes.LOGIN, arguments: isDriver);
    }
  }
}

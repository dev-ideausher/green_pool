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
      //? for testing updateDetailsAPI
      // Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: isDriver);
      //?original flow
      Get.toNamed(Routes.MATCHING_RIDES, arguments: isDriver);
    } else {
      Get.offNamed(Routes.CREATE_ACCOUNT, arguments: isDriver);
    }
  }
}

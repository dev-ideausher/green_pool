import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), () => decideRouting());
  }

  decideRouting() {
    if (Get.find<GetStorageService>().isLoggedIn) {
      Get.offNamed(Routes.BOTTOM_NAVIGATION);
      // if (Get.find<GetStorageService>().profileStatus) {
      //   Get.offNamed(Routes.BOTTOM_NAVIGATION);
      // } else {
      //   if (Get.find<HomeController>().findingRide.value) {
      //     Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: true);
      //   } else {
      //     Get.offNamed(Routes.PROFILE_SETUP, arguments: true);
      //   }
      // }
    } else {
      Get.offNamed(Routes.ONBOARDING);
    }
  }
}

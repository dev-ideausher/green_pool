import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/home/views/bottom_navigation_view.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';

class SplashController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   Future.delayed(const Duration(seconds: 1), () {
  //     Get.offNamed(Routes.ONBOARDING);
  //   });
  // }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1), () => decideRouting());
  }

  decideRouting() {
    if (Get.find<GetStorageService>().getLoggedIn) {
      if (Get.find<GetStorageService>().profileStatus) {
        Get.off(() => const BottomNavigationView());
      } else {
        if (Get.find<HomeController>().findingRide.value) {
          Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: false);
        } else {
          Get.offNamed(Routes.PROFILE_SETUP, arguments: true);
        }
      }
    } else {
      Get.offNamed(Routes.ONBOARDING);
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

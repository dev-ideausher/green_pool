import 'package:get/get.dart';
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
    Get.find<GetStorageService>().getLoggedIn
        ? Get.off(()=> const BottomNavigationView())
        : Get.offNamed( Routes.ONBOARDING);
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

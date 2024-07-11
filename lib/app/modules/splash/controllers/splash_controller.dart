import 'package:get/get.dart';

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
    } else {
      Get.offNamed(Routes.ONBOARDING);
    }
  }
}

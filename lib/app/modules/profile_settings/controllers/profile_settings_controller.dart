import 'package:get/get.dart';

import '../../../services/storage.dart';

class ProfileSettingsController extends GetxController {
  RxString profilePic = "".obs;
  RxString fullName = "".obs;

  @override
  void onInit() {
    super.onInit();
    updateInfo();
  }

  void updateInfo() {
    profilePic.value = Get.find<GetStorageService>().profilePicUrl ?? "";
    fullName.value = Get.find<GetStorageService>().getUserName ?? "";
  }
}

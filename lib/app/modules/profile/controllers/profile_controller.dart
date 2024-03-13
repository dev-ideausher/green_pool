import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import '../../../services/storage.dart';

class ProfileController extends GetxController {
  RxBool isSwitched = false.obs;
  var userInfo = Get.find<HomeController>().userInfo;
  // RxBool isSwitched = Get.find<GetStorageService>().isPinkMode;

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  bool toggleSwitch() {
    isSwitched.value = !isSwitched.value;
    Get.find<GetStorageService>().isPinkMode = isSwitched.value;
    print(Get.find<GetStorageService>().isPinkMode);
    return isSwitched.value;
  }
}

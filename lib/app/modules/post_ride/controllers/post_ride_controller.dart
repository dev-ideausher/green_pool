import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/carpool_schedule_view.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../../home/views/bottom_navigation_view.dart';

class PostRideController extends GetxController {
  RxBool isReturn = false.obs;
  RxBool isChecked = false.obs;
  RxInt tabIndex = 0.obs;
  List<RxBool> isSelectedList = List.generate(4, (index) => false.obs);
  List<RxBool> switchStates = List.generate(8, (index) => false.obs);
  final count = 0.obs;
  bool isDriver = false;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => CreateAccountController());
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
      // if (Get.find<HomeController>().findingRide.value) {
      //   Get.offNamed(Routes.PROFILE_SETUP);
      // } else {
      //   Get.off(() => const CarpoolScheduleView());
      // }
      Get.toNamed(Routes.PROFILE_SETUP, arguments: isDriver);

      //? the original flow Get.to(() => const CarpoolScheduleView());
    } else {
      Get.offNamed(Routes.LOGIN, arguments: isDriver);
    }
  }

  bool setReturn() {
    isReturn.value = !isReturn.value;
    return isReturn.value;
  }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  void setGuideLines() {
    if (isChecked.value == true) {
      Get.offAll(const BottomNavigationView());
    } else {
      showMySnackbar(msg: 'Terms and Conditions not accepted');
    }
  }

  void setSelected(int selectedIndex) {
    for (int i = 0; i < isSelectedList.length; i++) {
      isSelectedList[i](i == selectedIndex);
    }
  }

  void toggleSwitch(int index) {
    switchStates[index].value = !switchStates[index].value;
  }

  void increment() {
    if (count.value <= 2) {
      count.value++;
    }
  }

  void decrement() {
    if (count.value >= 1) {
      count.value--;
    }
  }
}

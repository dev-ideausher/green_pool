import 'package:get/get.dart';

import '../../../data/ride_history_model.dart';

class RideDetailsController extends GetxController {
  final Rx<RideHistoryModelData> rideHistory = RideHistoryModelData().obs;

  // final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    rideHistory.value = Get.arguments;
  }

  

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
}

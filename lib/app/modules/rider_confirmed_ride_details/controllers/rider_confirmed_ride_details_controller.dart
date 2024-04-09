import 'package:get/get.dart';

import '../../../data/my_rides_model.dart';

class RiderConfirmedRideDetailsController extends GetxController {
  final Rx<MyRidesModelData> myRidesModel = MyRidesModelData().obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

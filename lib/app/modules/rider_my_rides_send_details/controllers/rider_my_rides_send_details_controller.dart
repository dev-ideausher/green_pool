import 'package:get/get.dart';

import '../../rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';

class RiderMyRidesSendDetailsController extends GetxController {
  int index = 0;
  var riderSendRequestModel =
      Get.find<RiderMyRideRequestController>().riderSendRequestModel;

  @override
  void onInit() {
    super.onInit();
    index = Get.arguments;
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

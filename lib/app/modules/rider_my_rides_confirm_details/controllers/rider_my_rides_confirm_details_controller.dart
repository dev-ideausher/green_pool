import 'package:get/get.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';

class RiderMyRidesConfirmDetailsController extends GetxController {
  var riderConfirmRequestModel =
      Get.find<RiderMyRideRequestController>().riderConfirmRequestModel;
  int index = 0;

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

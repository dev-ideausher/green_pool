import 'package:get/get.dart';
import 'package:green_pool/app/data/rider_confirm_request_model.dart';

class RiderMyRidesConfirmDetailsController extends GetxController {
  var riderConfirmRequestModel = RiderConfirmRequestModelData();
  

  @override
  void onInit() {
    super.onInit();
    riderConfirmRequestModel = Get.arguments;
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

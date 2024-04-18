import 'package:get/get.dart';

import '../../../data/my_rides_model.dart';
import '../../../routes/app_pages.dart';

class RiderConfirmedRideDetailsController extends GetxController {
  final Rx<MyRidesModelData> myRidesModel = MyRidesModelData().obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments;
   print( "ride status "+(myRidesModel.value.isStarted ?? false).toString());
  }

  viewOnMap () {
    Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: myRidesModel.value);
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

import 'package:get/get.dart';

import '../../../data/booking_detail_model.dart';

class RatingRiderSideController extends GetxController {
  final Rx<BookingDetailModelData> myRidesModel = BookingDetailModelData().obs;
  int numberOfRiders = 3;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // myRidesModel.value = Get.arguments;
  }
}

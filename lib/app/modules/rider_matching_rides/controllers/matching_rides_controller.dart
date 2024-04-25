import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../find_ride/controllers/find_ride_controller.dart';

class MatchingRidesController extends GetxController {
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';
  var matchingRideResponse =
      Get.find<FindRideController>().matchingRideResponse;

  @override
  void onInit() {
    super.onInit();
    rideDetails = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  moveToFilter() {
    Get.toNamed(Routes.RIDER_FILTER, arguments: rideDetails)?.then((value) {
      matchingRideResponse.value = value;
      matchingRideResponse.refresh();
    });
  }
}

import 'package:get/get.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';

class MatchingRidesController extends GetxController {
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';
  var matchingRideResponse = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    matchingRideResponse = Get.arguments['matchingRidesModel'];
    rideDetails = Get.arguments['findRideData'];
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
    Get.toNamed(Routes.RIDER_FILTER, arguments: {
      'rideDetails': rideDetails,
      'matchingRidesModel': matchingRideResponse.value
    })?.then((value) {
      matchingRideResponse.value = value;
      matchingRideResponse.refresh();
    });
  }

  void moveToDriverDetails(index) {
    driverRideId = "${matchingRideResponse.value.data?[index]?.Id}";
    minStopDistance =
        "${matchingRideResponse.value.data?[index]?.minStopDistance}";
    Get.toNamed(Routes.DRIVER_DETAILS, arguments: {
      'rideDetails': rideDetails,
      'driverRideId': driverRideId,
      'distance': minStopDistance,
      'matchingRidesmodel': matchingRideResponse.value.data?[index]
    });
  }
}

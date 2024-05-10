import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/gp_util.dart';

class MatchingRidesController extends GetxController {
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  // String minStopDistance = '';
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  final Rx<MatchingRidesModel> matchingRidesModel = MatchingRidesModel().obs;

  @override
  void onInit() {
    super.onInit();
    matchingRidesModel.value = Get.arguments['matchingRidesModel'];
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
      'matchingRidesModel': matchingRidesModel.value
    })?.then((value) {
      matchingRidesModel.value = value;
      matchingRidesModel.refresh();
    });
  }

  void moveToDriverDetails(index) {
    driverRideId = "${matchingRidesModel.value.data?[index]?.Id}";
    // minStopDistance =
    //     "${matchingRidesModel.value.data?[index]?.minStopDistance}";
    Get.toNamed(Routes.DRIVER_DETAILS, arguments: {
      'rideDetails': rideDetails,
      'driverRideId': driverRideId,
      'distance': GpUtil.calculateDistance(
              startLat: latitude,
              startLong: longitude,
              endLat: matchingRidesModel
                      .value.data?[index]?.origin?.coordinates?.last ??
                  latitude,
              endLong: matchingRidesModel
                      .value.data?[index]?.origin?.coordinates?.first ??
                  longitude)
          .toStringAsFixed(2),
      'matchingRidesmodel': matchingRidesModel.value.data?[index]
    });
  }
}

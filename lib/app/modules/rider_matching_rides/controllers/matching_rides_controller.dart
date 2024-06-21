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

  Future<void> moveToDriverDetails(index) async {
    driverRideId = "${matchingRidesModel.value.data?[index]?.Id}";
    // minStopDistance =
    //     "${matchingRidesModel.value.data?[index]?.minStopDistance}";

    final distance = await GpUtil.calculateDistanceInInt(
        startLat:
            matchingRidesModel.value.data?[index]?.origin?.coordinates?.last ??
                latitude,
        startLong:
            matchingRidesModel.value.data?[index]?.origin?.coordinates?.first ??
                longitude,
        endLat: matchingRidesModel
                .value.data?[index]?.destination?.coordinates?.last ??
            latitude,
        endLong: matchingRidesModel
                .value.data?[index]?.destination?.coordinates?.first ??
            longitude);
    Get.toNamed(Routes.DRIVER_DETAILS, arguments: {
      'rideDetails': rideDetails,
      'driverRideId': driverRideId,
      "price": (matchingRidesModel.value.data?[index]?.price)! *
              (rideDetails?['ridesDetails']['seatAvailable']) ??
          0,
      'distance': distance.toString(),
      'matchingRidesmodel': matchingRidesModel.value.data?[index]
    });
  }
}

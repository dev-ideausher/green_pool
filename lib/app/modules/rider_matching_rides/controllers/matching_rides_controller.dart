import 'package:get/get.dart';
import '../../find_ride/controllers/find_ride_controller.dart';

class MatchingRidesController extends GetxController {
  String riderRideId = '';
  String driverRideId = '';
  String minStopDistance = '';
  var matchingRideResponse =
      Get.find<FindRideController>().matchingRideResponse;

  // @override
  // void onInit() {
    // super.onInit();
    // riderRideId = Get.arguments;
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  matchingRidesAPI() async {
    // try {
    //   final response = await APIManager.getMatchingRides();
    //   var data = jsonDecode(response.toString());
    //   matchingRideResponse.value = MatchingRidesModel.fromJson(data);
    // } catch (e) {
    //   throw Exception(e);
    // }
  }
}

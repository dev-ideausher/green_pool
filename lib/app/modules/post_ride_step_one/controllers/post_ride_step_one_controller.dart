import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';
import '../../origin/controllers/origin_controller.dart';

class PostRideStepOneController extends GetxController {
  RxBool isActive = false.obs;
  RxBool isStop1Added = false.obs;
  final RxBool isDriver = false.obs;
  var postRideModel = PostRideModel().obs;

  RxDouble originLatitude = 0.0.obs;
  RxDouble originLongitude = 0.0.obs;
  TextEditingController originTextController = TextEditingController();
  RxDouble destLatitude = 0.0.obs;
  RxDouble destLongitude = 0.0.obs;
  TextEditingController destinationTextController = TextEditingController();
  RxDouble stop1Lat = 0.0.obs;
  RxDouble stop1Long = 0.0.obs;
  TextEditingController stop1TextController = TextEditingController();
  RxDouble stop2Lat = 0.0.obs;
  RxDouble stop2Long = 0.0.obs;
  TextEditingController stop2TextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    isDriver.value = Get.arguments;
  }

  moveToSetOrigin() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.origin)?.then(
      (value) => setActiveStatePostRideView(),
    );
  }

  moveToSetDestination() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.destination)
        ?.then(
      (value) => setActiveStatePostRideView(),
    );
  }

  moveToSetStop1() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.addStop1)
        ?.then(
      (value) => isStop1Added.value = true,
    );
  }

  moveToSetStop2() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.addStop2);
  }

  setActiveStatePostRideView() {
    if (originTextController.value.text.isNotEmpty &&
        destinationTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  decideRouting() {
    // Decides if the user is logged in and redirects accordingly
    if (Get.find<GetStorageService>().getLoggedIn) {
      if (Get.find<HomeController>().userInfo.value.data?.vehicleStatus ==
          false) {
        showMySnackbar(msg: 'Please fill in vehicle details');
        Get.toNamed(Routes.VEHICLE_SETUP, arguments: false);
      } else {
        Get.toNamed(
          Routes.POST_RIDE_STEP_TWO,
          arguments: PostRideModel(
              ridesDetails: PostRideModelRidesDetails(
                  origin: PostRideModelRidesDetailsOrigin(
                      name: originTextController.value.text,
                      latitude: originLatitude.value,
                      longitude: originLongitude.value),
                  destination: PostRideModelRidesDetailsDestination(
                      name: destinationTextController.value.text,
                      latitude: destLatitude.value,
                      longitude: destLongitude.value),
                  stops: [
                PostRideModelRidesDetailsStops(
                    name: stop1TextController.value.text,
                    latitude: stop1Lat.value,
                    longitude: stop1Long.value),
                PostRideModelRidesDetailsStops(
                    name: stop2TextController.value.text,
                    latitude: stop2Lat.value,
                    longitude: stop2Long.value),
              ])),
        );
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: {
        'fromNavBar': false,
        'isDriver': true,
        'postRideModel': PostRideModel(
            ridesDetails: PostRideModelRidesDetails(
                origin: PostRideModelRidesDetailsOrigin(
                    name: originTextController.value.text,
                    latitude: originLatitude.value,
                    longitude: originLongitude.value),
                destination: PostRideModelRidesDetailsDestination(
                    name: destinationTextController.value.text,
                    latitude: destLatitude.value,
                    longitude: destLongitude.value),
                stops: [
              PostRideModelRidesDetailsStops(
                  name: stop1TextController.value.text,
                  latitude: stop1Lat.value,
                  longitude: stop1Long.value),
              PostRideModelRidesDetailsStops(
                  name: stop2TextController.value.text,
                  latitude: stop2Lat.value,
                  longitude: stop2Long.value),
            ])),
      });
    }
  }
}

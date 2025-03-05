import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/storage.dart';
import '../../origin/controllers/origin_controller.dart';

class PostRideStepOneController extends GetxController {
  RxBool isActive = false.obs;
  RxBool isStop1Added = false.obs;
  RxBool isStop2Added = false.obs;

  RxBool isOriginAdded = false.obs;
  RxBool isDestinationAdded = false.obs;
  final RxBool isDriver = false.obs;
  var postRideModel = PostRideModel().obs;
  var prevRideData = PostRideModel().obs;

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

  void swapTextFields() {
    // Swap origin and destination values
    final tempName = originTextController.text;
    final tempLat = originLatitude.value;
    final tempLong = originLongitude.value;

    originTextController.text = destinationTextController.text;
    originLatitude.value = destLatitude.value;
    originLongitude.value = destLongitude.value;

    destinationTextController.text = tempName;
    destLatitude.value = tempLat;
    destLongitude.value = tempLong;

    // Update flags
    isOriginAdded.value = originTextController.text.isNotEmpty;
    isDestinationAdded.value = destinationTextController.text.isNotEmpty;
  }

  moveToSetOrigin() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.origin)
        ?.then((value) {
      if (originTextController.value.text.isNotEmpty) {
        isOriginAdded.value = true;
      } else {
        isOriginAdded.value = false;
      }
      setActiveStatePostRideView();
    });
  }

  moveToSetDestination() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.destination)
        ?.then(
      (value) {
        if (destinationTextController.value.text.isNotEmpty) {
          isDestinationAdded.value = true;
        } else {
          isDestinationAdded.value = false;
        }
        setActiveStatePostRideView();
      },
    );
  }

  moveToSetStop1() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.addStop1)
        ?.then(
      (value) {
        if (stop1TextController.value.text.isNotEmpty) {
          isStop1Added.value = true;
        } else {
          isStop1Added.value = false;
        }
      },
    );
  }

  moveToSetStop2() {
    Get.toNamed(Routes.SEARCH_ADDRESS, arguments: LocationValues.addStop2)
        ?.then((value) {
      if (stop2TextController.value.text.isNotEmpty) {
        isStop2Added.value = true;
      } else {
        isStop2Added.value = false;
      }
    });
  }

  setActiveStatePostRideView() {
    if (originTextController.value.text.isNotEmpty &&
        destinationTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  void moveToStepTwo() {
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

  removeStop1() {
    stop1TextController.clear();
    stop1Lat.value = 0.0;
    stop1Long.value = 0.0;
    isStop1Added.value = false;
  }

  removeStop2() {
    stop2TextController.clear();
    stop2Lat.value = 0.0;
    stop2Long.value = 0.0;
    isStop2Added.value = false;
  }

  removeOrigin() {
    originTextController.clear();
    isOriginAdded.value = false;
    originLatitude.value = 0.0;
    originLongitude.value = 0.0;
  }

  removeDestination() {
    destinationTextController.clear();
    isDestinationAdded.value = false;
    destLatitude.value = 0.0;
    destLongitude.value = 0.0;
  }

  void setPrevRideData() {
    final prevRide = Get.find<GetStorageService>().getPostRideData();
    prevRideData.value = prevRide ?? PostRideModel();
    final rideDetails = prevRideData.value.ridesDetails;

    originLatitude.value = rideDetails!.origin!.latitude!;
    originLongitude.value = rideDetails.origin!.longitude!;
    originTextController.text = rideDetails.origin!.name!;
    if (originTextController.text != "") {
      isOriginAdded.value = true;
    }

    destLatitude.value = rideDetails.destination!.latitude!;
    destLongitude.value = rideDetails.destination!.longitude!;
    destinationTextController.text = rideDetails.destination!.name!;
    if (destinationTextController.text != "") {
      isDestinationAdded.value = true;
    }

    stop1Lat.value = rideDetails.stops![0].latitude!;
    stop1Long.value = rideDetails.stops![0].longitude!;
    stop1TextController.text = rideDetails.stops![0].name!;
    if (stop1TextController.text != "") {
      isStop1Added.value = true;
    }

    stop2Lat.value = rideDetails.stops![1].latitude!;
    stop2Long.value = rideDetails.stops![1].longitude!;
    stop2TextController.text = rideDetails.stops![1].name!;
    if (stop2TextController.text != "") {
      isStop2Added.value = true;
    }
    setActiveStatePostRideView();
  }
}

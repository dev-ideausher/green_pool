import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides/controllers/my_rides_controller.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController? pageController = PageController();
  final RxBool findingRide = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxBool isPink = Get.find<ProfileController>().isSwitched.value.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => MyRidesController());
    _determinePosition().then((value) => {
          latitude.value = value.latitude,
          longitude.value = value.longitude,
        });
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

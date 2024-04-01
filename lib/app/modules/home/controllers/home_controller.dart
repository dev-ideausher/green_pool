import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../data/user_info_model.dart';
import '../../../services/dio/api_service.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController? pageController = PageController();
  final RxBool findingRide = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var userInfo = UserInfoModel().obs;
  RxString welcomeText = "Welcome".obs;

  // RxBool isPink = Get.find<ProfileController>().isSwitched.value.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  //! temporary basis - userInfoAPI
  void onInit() {
    super.onInit();
    // Get.lazyPut(() => MyRidesController());
    _determinePosition().then((value) => {
          latitude.value = value.latitude,
          longitude.value = value.longitude,
        });
  }

  @override
  void onReady() async {
    super.onReady();
    userInfoAPI();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  userInfoAPI() async {
    if (Get.find<GetStorageService>().getLoggedIn == true) {
      final response = await APIManager.getUserByID();
      var data = jsonDecode(response.toString());
      userInfo.value = UserInfoModel.fromJson(data);
      log("User info API called");
    } else {}
  }

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

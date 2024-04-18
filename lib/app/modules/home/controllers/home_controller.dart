import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_pool/app/services/push_notification_service.dart';
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
  Future<void> onInit() async {
    super.onInit();

    await _determinePosition().then((value) => {
          latitude.value = value.latitude,
          longitude.value = value.longitude,
        });
    await setupMessage();
    onChangeLocation();
  }

  void onChangeLocation() {
    const LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) async {
      if (position != null) {
        DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('locations');
        databaseReference.child(Get.find<GetStorageService>().getUserAppId ?? "").set({'latitude': position.latitude, 'longitude': position.longitude});
      }
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
      PushNotificationService.subFcm("${userInfo.value.data?.Id}");
      log("User info API called");
    } else {}
  }

  setupMessage() async {
    await PushNotificationService().setupInteractedMessage();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationService().saveNotification(initialMessage);
      // App received a notification when it was killed
    }
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

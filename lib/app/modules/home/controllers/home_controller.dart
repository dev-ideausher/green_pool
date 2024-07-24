import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_pool/app/modules/home/views/noti_bottomsheet.dart';
import 'package:green_pool/app/modules/home/views/permissions_location.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/location_service.dart';
import 'package:green_pool/app/services/push_notification_service.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController();
  final RxBool findingRide = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var userInfo = UserInfoModel().obs;
  RxString welcomeText = Strings.welcome.obs;
  RxBool isPinkModeOn = false.obs;
  bool canPop = false;

  void changeTabIndex(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeIn,
    );
    selectedIndex.value = index;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      await userInfoAPI();
      latitude.value = await LocationService().getLatitude();
      longitude.value = await LocationService().getLongitude();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onChangeLocation() {
    const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      if (position != null) {
        DatabaseReference databaseReference =
            FirebaseDatabase.instance.ref().child('locations');
        databaseReference
            .child(Get.find<GetStorageService>().getUserAppId ?? "")
            .set({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'heading': position.heading
        });
      }
    });
  }

  @override
  void onReady() async {
    super.onReady();
  }

  userInfoAPI() async {
    final storageService = Get.find<GetStorageService>();

    // Check the current location permission status
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    // Check if the user is logged in
    if (storageService.isLoggedIn == true) {
      try {
        final response = await APIManager.getUserByID();
        var data = jsonDecode(response.toString());
        userInfo.value = UserInfoModel.fromJson(data);

        //store values
        storageService.setUserAppId = userInfo.value.data?.Id;
        storageService.setUserName = userInfo.value.data?.fullName ?? "";
        storageService.profilePicUrl = userInfo.value.data?.profilePic?.url;
        storageService.setFirebaseUid = userInfo.value.data?.firebaseUid ?? "";
        userInfo.refresh();

        // Subscribe to FCM notifications using the user ID
        PushNotificationService.subFcm("${userInfo.value.data?.Id}");

        // Update the pink mode status from storage service
        isPinkModeOn.value = storageService.isPinkMode;
        print(storageService.encjwToken);

        //method to handle location changes
        onChangeLocation();

        // Check and request location permission if necessary
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.unableToDetermine) {
          Get.to(const PermissionsLocation());
          return Future.error('Location services are disabled.');
        } else {
          await determinePosition().then((value) => {
                latitude.value = value.latitude,
                longitude.value = value.longitude,
              });
        }
        // Setup message notifications
        setupMessage();
      } catch (e) {
        debugPrint(e.toString());
      }
      log("User info API called");
    } else {
      print("User not logged in");
    }
  }

  setupMessage() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('logo'),
            iOS: DarwinInitializationSettings());
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    PushNotificationService(flutterLocalNotificationsPlugin)
        .setupInteractedMessage();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.unableToDetermine) {
        // Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        Get.back();
        await Permission.notification.isDenied.then((value) async {
          if (value) {
            Get.bottomSheet(const NotificationBottomSheet());
          }
        });
        latitude.value = await LocationService().getLatitude();
        longitude.value = await LocationService().getLongitude();
        return Future.error('Location permissions are granted');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.back();
      await Permission.notification.isDenied.then((value) async {
        if (value) {
          Get.bottomSheet(const NotificationBottomSheet());
        }
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  onTapBottomNavigation(index) {
    if (Get.find<GetStorageService>().isLoggedIn) {
      if (Get.find<GetStorageService>().profileStatus) {
        changeTabIndex(index);
        userInfo.refresh();
      } else {
        if (index != 0) {
          Get.toNamed(Routes.RIDER_PROFILE_SETUP,
              arguments: {"fromNavBar": true, "fullName": ""});
          showMySnackbar(msg: Strings.pleaseCompleteProfileSetup);
        }
      }
    } else {
      if (index != 0) {
        print(
            "GET STORAGE IS LOGGED IN: ${Get.find<GetStorageService>().isLoggedIn.toString()}");
        Get.toNamed(Routes.LOGIN,
            arguments: {'isDriver': false, 'fromNavBar': true});
      }
    }
  }
}

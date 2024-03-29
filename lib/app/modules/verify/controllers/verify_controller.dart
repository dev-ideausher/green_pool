// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../../../data/create_acc_data.dart';
import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';

class VerifyController extends GetxController {
  final otpController = TextEditingController();
  CreateAccData createAccData = CreateAccData();

  bool isDriver = false;
  String fullName = '';
  String phoneNumber = '';

  @override
  void onInit() {
    super.onInit();
    // createAccData.phoneNumber = Get.arguments.phoneNumber;
    isDriver = Get.arguments['isDriver'];
    phoneNumber = Get.arguments['phoneNumber'];
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  verifyOTP() async {
    try {
      bool isStatus = await Get.find<AuthService>()
          .verifyMobileOtp(otp: otpController.text);
      if (isStatus) {
        // await Get.find<LoginController>().loginAPI();
        await loginAPI();
      } else {
        showMySnackbar(msg: "Error saving user data");
      }
    } catch (e) {
      print('otp error: $e');
    }
  }

  loginAPI() async {
    //   try {
    //     final response = await APIManager.getLogin();
    //     final userInfo = UserInfoModel.fromJson(response.data);
    //     Get.find<GetStorageService>().setUserAppId = userInfo.data?.Id;

    //     //? here if the profileStatus is not true which means it is a new user or the user did not fill the entire user data, so the user will be automatically redirected to the Profile Setup
    //     if (userInfo.status! &&
    //         userInfo.data!.profileStatus! &&
    //         userInfo.data!.vehicleStatus!) {
    //       Get.find<GetStorageService>().setLoggedIn = true;
    //       Get.find<GetStorageService>().setProfileStatus = true;
    //       Get.find<GetStorageService>().setDriver = isDriver;
    //       Get.find<ProfileController>().userInfoAPI();

    //       //? if user status is logged in then check whether the user is findingRide.
    //       if (Get.find<HomeController>().findingRide.value) {
    //         //? if user is not finding a ride then he should be redirected to Carpool schedule afte LOGIN
    //         // Get.offNamed(Routes.FIND_RIDE, arguments: isDriver);
    //         Get.back();
    //       } else {
    //         //? if user is finding a ride then he should be redirected to Matching ride
    //         Get.off(() => const CarpoolScheduleView(), arguments: isDriver);
    //       }
    //     } else {
    //       if (isDriver) {
    //         Get.offNamed(Routes.PROFILE_SETUP, arguments: {
    //           'isDriver': isDriver,
    //           'fullName': fullName,
    //         });
    //       } else {
    //         Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
    //           'isDriver': isDriver,
    //           'fullName': fullName,
    //         });
    //       }
    //     }
    //   } catch (e) {
    //     log("error: $e");
    //   }
    // }

    try {
      final response = await APIManager.getLogin();
      final userInfo = UserInfoModel.fromJson(response.data);
      Get.find<GetStorageService>().setUserAppId = userInfo.data?.Id;

      //? here if the profileStatus is not true which means it is a new user or the user did not fill the entire user data, so the user will be automatically redirected to the Profile Setup
      if (userInfo.status!) {
        if (Get.find<HomeController>().findingRide.value) {
          if (userInfo.data!.profileStatus!) {
            // Get.offNamed(Routes.FIND_RIDE, arguments: isDriver);
            Get.back();
          } else {
            Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: isDriver);
          }
        } else {
          if (userInfo.data!.profileStatus! && userInfo.data!.vehicleStatus!) {
            // Get.offNamed(Routes.CARPOOL_SCHEDULE, arguments: isDriver);
            Get.until((route) => Get.currentRoute == Routes.POST_RIDE);
          } else {
            Get.offNamed(Routes.PROFILE_SETUP, arguments: isDriver);
          }
        }
        Get.find<GetStorageService>().setLoggedIn = true;
        Get.find<GetStorageService>().setProfileStatus = true;
        Get.find<GetStorageService>().setDriver = isDriver;
        Get.find<HomeController>().userInfoAPI();
      } else {
        if (isDriver) {
          Get.offNamed(Routes.PROFILE_SETUP, arguments: isDriver);
        } else {
          Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: isDriver);
        }
      }
    } catch (e) {
      log("error: $e");
    }
  }
}

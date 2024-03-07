// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/verify/controllers/verify_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class CreateAccountController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isChecked = false.obs;
  bool isDriver = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String countryCode = "+1";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  setVisible() {
    isVisible.toggle();
  }

  checkValidation() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      formKey.currentState!.save();
      await otpAuth();
    }
  }

  String? nameValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Check if the value contains only letters (and optionally spaces)
    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null; // Return null if the value is valid
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  otpAuth() async {
    try {
      print("phone number: ${phoneNumberController.text}");
      if (isChecked.value == true) {
        await Get.find<AuthService>()
            .mobileOtp(phoneno: countryCode + phoneNumberController.text);

        await Get.offNamed(Routes.VERIFY,
            // arguments: CreateAccData(
            //     fullName: fullNameController.text,
            //     isDriver: isDriver,
            //     phoneNumber: phoneNumberController.text),
            arguments: {
              'isDriver': isDriver,
              'fullName': fullNameController.value.text,
              'phoneNumber': phoneNumberController.value.text
            });
      } else {
        showMySnackbar(msg: 'Terms and Conditions not accepted');
      }
    } catch (e) {
      print('error: $e');
    }
  }

  void googleAuth() async {
    try {
      await Get.find<AuthService>().google();
      await loginAPI();
    } catch (error) {
      log("google auth error: $error");
      showMySnackbar(msg: "Error");
    }
  }

  loginAPI() async {
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
        Get.find<ProfileController>().userInfoAPI();
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


// onboardingAPI() async {
//   try {
//     await APIManager.getLogin();
//   } on Exception catch (e) {
//     log(e.toString());
//   }
// }

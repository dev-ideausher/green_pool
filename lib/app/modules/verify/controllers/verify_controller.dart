import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
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
  final auth = FirebaseAuthenticationService();
  bool isDriver = false;
  bool fromNavBar = false;
  String fullName = '';
  String phoneNumber = '';
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
      } else {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
      }
    } catch (e) {
      isDriver = Get.arguments['isDriver'];
      phoneNumber = Get.arguments['phoneNumber']??"";
      fromNavBar = Get.arguments['fromNavBar'];
    }
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
      bool isStatus = await Get.find<AuthService>().verifyMobileOtp(otp: otpController.text);
      if (isStatus) {
        await loginAPI();
      } else {
        showMySnackbar(msg: "Error saving user data");
      }
    } catch (e) {
      debugPrint('otp error: $e');
    }
  }

  loginAPI() async {
    try {
      final response = await APIManager.getLogin();
      final userInfo = UserInfoModel.fromJson(response.data);
      Get.find<GetStorageService>().setUserAppId = userInfo.data?.Id;
      Get.find<GetStorageService>().profilePicUrl = userInfo.data?.profilePic?.url ?? "";
      Get.find<GetStorageService>().isPinkMode = userInfo.data?.pinkMode ?? false;
      Get.find<HomeController>().isPinkModeOn.value = userInfo.data?.pinkMode ?? false;
      //? here if the profileStatus is not true which means it is a new user or the user did not fill the entire user data, so the user will be automatically redirected to the Profile Setup
      if (fromNavBar) {
        Get.find<GetStorageService>().setLoggedIn = true;
        Get.find<GetStorageService>().setProfileStatus = true;
        Get.find<GetStorageService>().setDriver = isDriver;
        Get.find<HomeController>().userInfoAPI();
        if (userInfo.data!.profileStatus!) {
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);

          showMySnackbar(msg: 'Login Successful');
        } else {
          Get.offNamed(Routes.VERIFICATION_DONE, arguments: {'fromNavBar': fromNavBar, 'isDriver': false});
        }
      } else if (userInfo.status!) {
        if (Get.find<HomeController>().findingRide.value) {
          if (userInfo.data!.profileStatus!) {
            Get.back();
            showMySnackbar(msg: "Successfully logged in");
          } else {
            Get.offNamed(Routes.VERIFICATION_DONE, arguments: {'isDriver': isDriver, 'fromNavBar': false, 'findRideModel': findRideModel.value});
          }
        } else {
          if (userInfo.data!.profileStatus! && userInfo.data!.vehicleStatus!) {
            showMySnackbar(msg: "Successfully logged in");
            Get.offNamed(Routes.POST_RIDE_STEP_TWO, arguments: postRideModel.value);
          } else {
            //TODO: what to show when it is a new user but tries to LOGIN directly
            Get.offNamed(Routes.VERIFICATION_DONE, arguments: {'isDriver': isDriver, 'fromNavBar': false, 'postRideModel': postRideModel.value});
          }
        }
        Get.find<GetStorageService>().setLoggedIn = true;
        Get.find<GetStorageService>().setProfileStatus = true;
        Get.find<GetStorageService>().setDriver = isDriver;
        Get.find<HomeController>().userInfoAPI();
      } else {
        if (isDriver) {
          Get.offNamed(Routes.PROFILE_SETUP, arguments: {'fromNavBar': false, 'postRideModel': postRideModel.value});
        } else {
          Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: {'fromNavBar': false, 'findRideModel': findRideModel.value});
        }
      }
    } catch (e) {
      debugPrint("login error: $e");
    }
  }
}

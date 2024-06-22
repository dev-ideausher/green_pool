import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../../../data/create_acc_data.dart';
import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/dio/exceptions.dart';
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
  RxInt seconds = 30.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
        fullName = Get.arguments['fullName'];
      } else {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
        fullName = Get.arguments['fullName'];
      }
    } catch (e) {
      isDriver = Get.arguments['isDriver'];
      phoneNumber = Get.arguments['phoneNumber'] ?? "";
      fromNavBar = Get.arguments['fromNavBar'];
    }
    startTimer();
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
        await loginAPI();
      } else {
        showMySnackbar(msg: "Error saving user data");
      }
    } catch (e) {
      debugPrint('otp error: $e');
    }
  }

  otpAuth() async {
    try {
      await Get.find<AuthService>().mobileOtp(phoneno: phoneNumber);
      seconds.value = 30;
      startTimer();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> loginAPI() async {
    final storageService = Get.find<GetStorageService>();
    final homeController = Get.find<HomeController>();
    final authService = Get.find<AuthService>();
    if (fullName != '') {
      //USER CREATING NEW ACC
      try {
        final response =
            await APIManager.postRegisterAcc(body: {"fullName": fullName});
        final userInfo = UserInfoModel.fromJson(response.data);

        _handleNewUser(userInfo, authService, homeController, storageService);
      } catch (e) {
        _handleError(e);
      }
    } else {
      //USER LOGIN
      try {
        final response = await APIManager.postLogin();
        final userInfo = UserInfoModel.fromJson(response.data);

        _handleUserLogin(userInfo, authService, homeController, storageService);
      } catch (e) {
        _handleError(e);
      }
    }
  }

  void _handleNewUser(UserInfoModel userInfo, AuthService authService,
      HomeController homeController, GetStorageService storageService) {
    //if profile status is true then the user had previously logged in and already has an acc
    if (userInfo.data!.profileStatus!) {
      if (fromNavBar) {
        //if user is coming from nav bar then they should logout and should not transfer post/find ride data

        Get.offNamed(Routes.LOGIN,
            arguments: {'isDriver': isDriver, 'fromNavBar': fromNavBar});
        authService.logOutUser();
        // PushNotificationService.unsubFcm("${userInfo.data?.Id}");
        showMySnackbar(msg: "This account already exists. Please Login");
      } else {
        //if the user is trying to post or find a ride then they should be logged out and redirected to Login page with the current data that they have entered
        try {
          if (homeController.findingRide.value) {
            //if the user was finding
            Get.offNamed(Routes.LOGIN, arguments: {
              'isDriver': isDriver,
              'fromNavBar': fromNavBar,
              'findRideModel': findRideModel.value
            });
          } else {
            //if the user was posting
            Get.offNamed(Routes.LOGIN, arguments: {
              'isDriver': isDriver,
              'fromNavBar': fromNavBar,
              'postRideModel': postRideModel.value
            });
          }
          authService.logOutUser();
          // PushNotificationService.unsubFcm("${userInfo.data?.Id}");
          showMySnackbar(msg: "This account already exists. Please Login");
        } catch (e) {
          throw Exception(e.toString());
        }
      }
    } else {
      //check if the user is creating acc from navBar
      if (fromNavBar) {
        //user wont have post/find ride data
        Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
          'fromNavBar': fromNavBar,
          'isDriver': false,
        });
      } else {
        //user will have post/find ride data which needs to be transferred
        //check if driver or rider
        if (homeController.findingRide.value) {
          //rider
          Get.offNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
            'fromNavBar': false,
            'findRideModel': findRideModel.value,
          });
        } else {
          //driver
          Get.offNamed(Routes.PROFILE_SETUP, arguments: {
            'fromNavBar': false,
            'postRideModel': postRideModel.value,
          });
        }
      }
    }
  }

  Future<void> _handleUserLogin(UserInfoModel userInfo, AuthService authService,
      HomeController homeController, GetStorageService storageService) async {
    //if profile status is false then this is a new user and needs to create a new acc
    if (userInfo.data!.profileStatus!) {
      // Set user information in storage service
      storageService.setUserAppId = userInfo.data?.Id;
      storageService.setUserName = userInfo.data?.fullName;
      storageService.profilePicUrl = userInfo.data?.profilePic?.url ?? "";
      storageService.isPinkMode = userInfo.data?.pinkMode ?? false;

      // Update UI elements
      homeController.isPinkModeOn.value = userInfo.data?.pinkMode ?? false;

      //if the user is trying to login from nav bar
      if (fromNavBar) {
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        showMySnackbar(msg: 'Login Successful');
        storageService.profileStatus = true;
        storageService.isLoggedIn = true;
        await homeController.userInfoAPI();
      } else {
        //check if the user is driver
        if (homeController.findingRide.value) {
          //user is rider
          Get.back();
          showMySnackbar(msg: "Successfully logged in");
          storageService.isLoggedIn = true;
          storageService.profileStatus = true;
          await homeController.userInfoAPI();
        } else {
          //user is driver
          //if the user is driver then check if previously they have filled vehicle details
          if (userInfo.data!.vehicleStatus!) {
            //if they have filled then proceed to post ride step 2
            Get.offNamed(Routes.POST_RIDE_STEP_TWO,
                arguments: postRideModel.value);
            showMySnackbar(msg: "Successfully logged in");
            storageService.isLoggedIn = true;
            storageService.profileStatus = true;
            storageService.setDriver = true;
            await homeController.userInfoAPI();
          } else {
            //if not then redirect to vehicle details page
            Get.toNamed(Routes.VEHICLE_SETUP, arguments: postRideModel.value);
            showMySnackbar(msg: "To proceed please fill in vehicle details");
          }
        }
      }
    } else {
      //redirecting to create acc page
      if (fromNavBar) {
        //if user is coming from nav bar then they should logout and should not transfer post/find ride data

        Get.offNamed(Routes.CREATE_ACCOUNT,
            arguments: {'isDriver': isDriver, 'fromNavBar': fromNavBar});
        authService.logOutUser();
        // PushNotificationService.unsubFcm("${userInfo.data?.Id}");
        showMySnackbar(
            msg: "This account does not exists. Please create a new acc");
      } else {
        //if the user is trying to post or find a ride then they should be logged out and redirected to Login page with the current data that they have entered
        try {
          if (homeController.findingRide.value) {
            //if the user was finding
            Get.offNamed(Routes.CREATE_ACCOUNT, arguments: {
              'isDriver': isDriver,
              'fromNavBar': fromNavBar,
              'findRideModel': findRideModel.value
            });
          } else {
            //if the user was posting
            Get.offNamed(Routes.CREATE_ACCOUNT, arguments: {
              'isDriver': isDriver,
              'fromNavBar': fromNavBar,
              'postRideModel': postRideModel.value
            });
          }

          authService.logOutUser();
          // PushNotificationService.unsubFcm("${userInfo.data?.Id}");
          showMySnackbar(
              msg: "This account does not exists. Please create a new acc");
        } catch (e) {
          throw Exception(e.toString());
        }
      }
    }
  }

  Future<void> _handleError(dynamic e) async {
    try {
      final errorMessage =
          DioExceptions.fromDioError(e as DioException).message;

      if (errorMessage == "User doesn't exist. Please create account" ||
          errorMessage == "User doesn't exist anymore") {
        await _navigateToProfileSetup();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _navigateToProfileSetup() async {
    if (fromNavBar) {
      Get.toNamed(Routes.PROFILE_SETUP, arguments: false);
    } else {
      if (Get.find<HomeController>().findingRide.value) {
        Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
          "fromNavBar": fromNavBar,
          "findRideModel": findRideModel.value,
        });
      } else {
        Get.toNamed(Routes.PROFILE_SETUP, arguments: {
          "fromNavBar": fromNavBar,
          "postRideModel": postRideModel.value,
        });
      }
    }
  }
}

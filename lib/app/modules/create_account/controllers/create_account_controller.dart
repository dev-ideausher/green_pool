import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/verify/controllers/verify_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/storage.dart';
import '../../home/controllers/home_controller.dart';

class CreateAccountController extends GetxController {
  RxBool isVisible = false.obs;
  RxBool isTermsAccepted = false.obs;
  bool isDriver = false;
  bool fromNavBar = false;
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  String countryCode = "+1";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
      } else {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
      }
    } catch (e) {
      isDriver = Get.arguments['isDriver'];
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

  void toggleCheckbox() {
    isTermsAccepted.value = !isTermsAccepted.value;
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

  moveToLogin() {
    if (Get.find<HomeController>().findingRide.value) {
      Get.offNamed(Routes.LOGIN, arguments: {
        'isDriver': isDriver,
        'fromNavBar': fromNavBar,
        'findRideModel': findRideModel.value
      });
    } else {
      Get.offNamed(Routes.LOGIN, arguments: {
        'isDriver': isDriver,
        'fromNavBar': fromNavBar,
        'postRideModel': postRideModel.value
      });
    }
  }

  otpAuth() async {
    try {
      if (isTermsAccepted.value == true) {
        await Get.find<AuthService>()
            .mobileOtp(phoneno: countryCode + phoneNumberController.text);

        if (Get.find<HomeController>().findingRide.value) {
          await Get.offNamed(Routes.VERIFY, arguments: {
            'isDriver': isDriver,
            'fullName': fullNameController.value.text,
            'phoneNumber': "$countryCode ${phoneNumberController.value.text}",
            'fromNavBar': fromNavBar,
            'findRideModel': findRideModel.value
          });
        } else {
          await Get.offNamed(Routes.VERIFY, arguments: {
            'isDriver': isDriver,
            'fullName': fullNameController.value.text,
            'phoneNumber': "$countryCode ${phoneNumberController.value.text}",
            'fromNavBar': fromNavBar,
            'postRideModel': postRideModel.value
          });
        }
      } else {
        showMySnackbar(msg: 'Terms and Conditions not accepted');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  void googleAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      bool isStatus = await Get.find<AuthService>().google();
      if (isStatus) {
        Get.find<VerifyController>().fullName =
            Get.find<GetStorageService>().getUserName;
        if (postRideModel.value != null) {
          Get.find<VerifyController>().postRideModel.value =
              postRideModel.value;
        } else if (findRideModel.value != null) {
          Get.find<VerifyController>().findRideModel.value =
              findRideModel.value;
        }
        await Get.find<VerifyController>().loginAPI();
      }
    } catch (error) {
      log("$error");
    }
  }

  Future<void> appleAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      final isStatus = await Get.find<AuthService>().apple();
      if (isStatus) {
        Get.find<VerifyController>().fullName =
            Get.find<GetStorageService>().getUserName;
        if (postRideModel.value != null) {
          Get.find<VerifyController>().postRideModel.value =
              postRideModel.value;
        } else if (findRideModel.value != null) {
          Get.find<VerifyController>().findRideModel.value =
              findRideModel.value;
        }
        await Get.find<VerifyController>().loginAPI();
      } else {
        Get.back();
        showMySnackbar(
            msg:
                "Unable to connect to Apple services. Please try again later.");
      }
    } catch (error) {
      log("$error");
    }
  }

  Future<void> facebookAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      final isStatus = await Get.find<AuthService>().facebook();
      if (isStatus) {
        Get.find<VerifyController>().fullName =
            Get.find<GetStorageService>().getUserName;
        if (postRideModel.value != null) {
          Get.find<VerifyController>().postRideModel.value =
              postRideModel.value;
        } else if (findRideModel.value != null) {
          Get.find<VerifyController>().findRideModel.value =
              findRideModel.value;
        }
        await Get.find<VerifyController>().loginAPI();
      } else {
        Get.back();
        showMySnackbar(
            msg:
                "Unable to connect to Facebook services. Please try again later.");
      }
    } catch (error) {
      log("$error");
    }
  }

  /*String? passwordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Check if the password meets the criteria (e.g., length, complexity)
    // For example, let's enforce a minimum length of 8 characters and at least one uppercase letter, one lowercase letter, one digit, and one special character.
    final RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    final RegExp digitRegExp = RegExp(r'[0-9]');
    final RegExp specialCharacterRegExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!upperCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!lowerCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!digitRegExp.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!specialCharacterRegExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Return null if the value is valid
  }*/
}

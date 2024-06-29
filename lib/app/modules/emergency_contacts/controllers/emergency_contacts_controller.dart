import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/emergency_contacts_model.dart';
import 'package:green_pool/app/data/emergency_update_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/find_ride_model.dart';
import '../../../data/post_ride_model.dart';
import '../../../routes/app_pages.dart';

class EmergencyContactsController extends GetxController {
  TextEditingController fullName1 = TextEditingController();
  TextEditingController fullName2 = TextEditingController();
  TextEditingController emergencyNumber1 = TextEditingController();
  TextEditingController emergencyNumber2 = TextEditingController();
  bool isProfileSetup = false;
  bool fromNavBar = false;
  bool isUser = false;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final RxBool isUpdated = false.obs;
  final RxBool buttonState = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments == null) {
      isUpdated.value = true;
    }
    try {
      if (Get.parameters['profileType'] != null) {
        isProfileSetup = true;
        if (Get.parameters['profileType'] == "user") {
          isUser = true;
        } else {
          isUser = false;
        }
      }
      try {
        fromNavBar = Get.arguments['fromNavBar'];
        if (isUser) {
          findRideModel.value = Get.arguments['findRideModel'];
        } else {
          postRideModel.value = Get.arguments['postRideModel'];
        }
      } catch (e) {
        fromNavBar = Get.arguments;
      }
    } catch (e) {
      final user = Get.find<HomeController>().userInfo.value.data;
      if (user?.emergencyContactDetails?.isNotEmpty ?? false) {
        fullName1.text = user?.emergencyContactDetails?[0]?.fullName ?? '';
        emergencyNumber1.text = user?.emergencyContactDetails?[0]?.phone ?? '';
        if (user?.emergencyContactDetails?.length == 2) {
          fullName2.text = user?.emergencyContactDetails?[1]?.fullName ?? '';
          emergencyNumber2.text =
              user?.emergencyContactDetails?[1]?.phone ?? '';
        }
      } else {
        isUpdated.value = false;
      }
    }
  }

  emergencyContactsAPI() async {
    List<EmergencyModelEmergencyContacts?>? emergencyContacts =
        <EmergencyModelEmergencyContacts>[];
    List<EmergencyModelEmergencyContactsUpdate?>? emergencyContactsUpdate =
        <EmergencyModelEmergencyContactsUpdate>[];

    if (isUpdated.value) {
      emergencyNumber1.text.isNotEmpty && fullName1.text.isNotEmpty
          ? emergencyContactsUpdate.add(EmergencyModelEmergencyContactsUpdate(
              id: (Get.find<HomeController>()
                      .userInfo
                      .value
                      .data
                      ?.emergencyContactDetails
                      ?.first
                      ?.Id ??
                  ""),
              phone: emergencyNumber1.text,
              fullName: fullName1.text))
          : null;

      emergencyNumber2.text.isNotEmpty && fullName2.text.isNotEmpty
          ? emergencyContactsUpdate.add(EmergencyModelEmergencyContactsUpdate(
              id: (Get.find<HomeController>()
                      .userInfo
                      .value
                      .data
                      ?.emergencyContactDetails?[1]
                      ?.Id ??
                  ""),
              phone: emergencyNumber2.text,
              fullName: fullName2.text))
          : null;
    } else {
      emergencyNumber1.text.isNotEmpty && fullName1.text.isNotEmpty
          ? emergencyContacts.add(EmergencyModelEmergencyContacts(
              phone: emergencyNumber1.text, fullName: fullName1.text))
          : null;

      emergencyNumber2.text.isNotEmpty && fullName2.text.isNotEmpty
          ? emergencyContacts.add(EmergencyModelEmergencyContacts(
              phone: emergencyNumber2.text, fullName: fullName2.text))
          : null;
    }

    final emergencyModel = EmergencyModel(emergencyContacts: emergencyContacts);

    try {
      if (isUpdated.value) {
        final emergencyModelUpdate =
            EmergencyUpdateModel(emergencyContacts: emergencyContactsUpdate);

        final res = await APIManager.emergencyContactsUpdate(
            body: emergencyModelUpdate.toJson());
        Get.find<HomeController>().userInfoAPI();
        // Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        showMySnackbar(msg: "Emergency contact updated");
      }
      await APIManager.postEmergencyDetails(body: emergencyModel.toJson());
      if (isProfileSetup) {
        if (isUser) {
          if (fromNavBar) {
            Get.find<HomeController>().userInfoAPI();
            Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
            showMySnackbar(msg: "Emergency contact updated");
          } else {
            Get.until((route) => Get.currentRoute == Routes.FIND_RIDE);
          }
        } else {
          if (fromNavBar) {
            Get.find<HomeController>().userInfoAPI();
            Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
            showMySnackbar(msg: "Emergency contact updated");
          } else {
            Get.offNamed(Routes.POST_RIDE_STEP_TWO,
                arguments: postRideModel.value);
          }
        }
      } else {
        Get.back();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  setButtonState() {
    if (emergencyNumber1.value.text.isNotEmpty &&
        fullName1.value.text.isNotEmpty) {
      buttonState.value = true;
    } else {
      buttonState.value = false;
    }
  }
}

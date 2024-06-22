import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/auth.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/push_notification_service.dart';
import '../../../services/snackbar.dart';

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

import '../../../services/text_style_util.dart';
import '../../rider_profile_setup/controllers/city_list.dart';

class UserDetailsController extends GetxController {
  RxString genderValue = "".obs;
  var userInformation = Get.find<HomeController>().userInfo.value.data;
  TextEditingController nameTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.fullName);
  TextEditingController emailTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.email);
  TextEditingController phoneTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.phone);
  TextEditingController city = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.city);
  // RxString selectedCity =
  //     (Get.find<HomeController>().userInfo.value.data?.city ?? 'Brampton').obs;
  TextEditingController genderTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.gender);
  TextEditingController dobTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.dob);
  Rx<File?>? selectedProfileImagePath = Rx<File?>(null);
  Rx<File?>? selectedIDImagePath = Rx<File?>(null);
  RxBool isProfilePicUpdated = false.obs;
  RxBool isIDPicUpdated = false.obs;
  RxBool isCityListExpanded = false.obs;
  RxList<String> cityNames = <String>[].obs;

  getProfileImage(ImageSource imageSource) async {
    XFile? pickedFile = await GpUtil.compressImage(imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath!.value = File(pickedFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isProfilePicUpdated.value = true;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    XFile? pickedIDFile = await GpUtil.compressImage(imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath!.value = File(pickedIDFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isIDPicUpdated.value = true;
      // isIDPicked.value = true;
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> updateDetailsAPI() async {
    final File? pickedImageFile = selectedProfileImagePath!.value;
    final File? pickedIDFile = selectedIDImagePath!.value;

    String profileExtension = pickedImageFile?.path.split('.').last ?? '';
    String verificationIDExtension = pickedIDFile?.path.split('.').last ?? '';
    String mediaType;
    String idMediaType;

    if (profileExtension == 'jpg' || profileExtension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (profileExtension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }

    if (verificationIDExtension == 'jpg' || verificationIDExtension == 'jpeg') {
      idMediaType = 'image/jpeg';
    } else if (verificationIDExtension == 'png') {
      idMediaType = 'image/png';
    } else {
      idMediaType = 'application/octet-stream';
    }

    dio.FormData userData;

    if (isProfilePicUpdated.value == true && isIDPicUpdated.value == true) {
      userData = dio.FormData.fromMap({
        'fullName': nameTextController.value.text.isEmpty
            ? userInformation?.fullName
            : nameTextController.value.text,
        'email': emailTextController.value.text.isEmpty
            ? userInformation?.email
            : emailTextController.value.text,
        'phone': userInformation?.phone,
        'gender': genderValue.value == ""
            ? userInformation?.gender
            : genderValue.value,
        'city': city.value.text,
        'dob': dobTextController.value.text.isEmpty
            ? userInformation?.dob
            : dobTextController.value.text,
        if (pickedIDFile != null)
          'idPic': await dio.MultipartFile.fromFile(
            pickedIDFile.path,
            contentType: MediaType.parse(idMediaType),
            filename: path.basename(pickedIDFile.path),
          ),
        if (pickedImageFile != null)
          'profilePic': await dio.MultipartFile.fromFile(
            pickedImageFile.path,
            contentType: MediaType.parse(mediaType),
            filename: path.basename(pickedImageFile.path),
          ),
      });
    } else if (isIDPicUpdated.value == true) {
      userData = dio.FormData.fromMap({
        'fullName': nameTextController.value.text.isEmpty
            ? userInformation?.fullName
            : nameTextController.value.text,
        'email': emailTextController.value.text.isEmpty
            ? userInformation?.email
            : emailTextController.value.text,
        'phone': userInformation?.phone,
        'gender': genderValue.value == ""
            ? userInformation?.gender
            : genderValue.value,
        'city': city.value.text,
        'dob': dobTextController.value.text.isEmpty
            ? userInformation?.dob
            : dobTextController.value.text,
        if (pickedIDFile != null)
          'idPic': await dio.MultipartFile.fromFile(
            pickedIDFile.path,
            contentType: MediaType.parse(idMediaType),
            filename: path.basename(pickedIDFile.path),
          ),
      });
    } else if (isProfilePicUpdated.value == true) {
      userData = dio.FormData.fromMap({
        'fullName': nameTextController.value.text.isEmpty
            ? userInformation?.fullName
            : nameTextController.value.text,
        'email': emailTextController.value.text.isEmpty
            ? userInformation?.email
            : emailTextController.value.text,
        'phone': userInformation?.phone,
        'gender': genderValue.value == ""
            ? userInformation?.gender
            : genderValue.value,
        'city': city.value.text,
        'dob': dobTextController.value.text.isEmpty
            ? userInformation?.dob
            : dobTextController.value.text,
        if (pickedImageFile != null)
          'profilePic': await dio.MultipartFile.fromFile(
            pickedImageFile.path,
            contentType: MediaType.parse(mediaType),
            filename: path.basename(pickedImageFile.path),
          ),
      });
    } else {
      userData = dio.FormData.fromMap({
        'fullName': nameTextController.value.text.isEmpty
            ? userInformation?.fullName
            : nameTextController.value.text,
        'email': emailTextController.value.text.isEmpty
            ? userInformation?.email
            : emailTextController.value.text,
        'phone': userInformation?.phone,
        'gender': genderValue.value == ""
            ? userInformation?.gender
            : genderValue.value,
        'city': city.value.text,
        'dob': dobTextController.value.text.isEmpty
            ? userInformation?.dob
            : dobTextController.value.text,
      });
    }

    try {
      final response = await APIManager.userDetails(body: userData);
      showMySnackbar(msg: response.data['message']);
      Get.find<HomeController>().userInfoAPI();
      Get.find<HomeController>().changeTabIndex(0);
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      log("updateDetailsAPI error: $e");
    }
  }

  deleteAccountAPI() async {
    try {
      Get.dialog(
        useSafeArea: true,
        Center(
          child: Container(
            padding: EdgeInsets.all(16.kh),
            height: 212.kh,
            width: 80.w,
            decoration: BoxDecoration(
              color: ColorUtil.kWhiteColor,
              borderRadius: BorderRadius.circular(8.kh),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.close),
                  ),
                ),
                Text(
                  Strings.deleteAccount,
                  style: TextStyleUtil.k18Semibold(),
                  textAlign: TextAlign.left,
                ).paddingSymmetric(vertical: 4.kh),
                Text(
                  Strings.areYouSureYouWantToDeleteYourAcc,
                  style: TextStyleUtil.k14Regular(
                    color: ColorUtil.kBlack04,
                  ),
                  textAlign: TextAlign.left,
                ).paddingOnly(bottom: 40.kh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreenPoolButton(
                      onPressed: () {
                        Get.back(); // Close the dialog
                      },
                      height: 40.kh,
                      width: 124.kw,
                      label: Strings.cancel,
                      fontSize: 14.kh,
                      isBorder: true,
                      padding: const EdgeInsets.all(8),
                    ),
                    GreenPoolButton(
                      onPressed: () async {
                        final res = await APIManager.deleteAccount();
                        PushNotificationService.unsubFcm(
                            "${Get.find<HomeController>().userInfo.value.data?.Id}");
                        Get.find<AuthService>().logOutUser();
                        Get.find<HomeController>().userInfoAPI();
                        Get.find<HomeController>().changeTabIndex(0);
                        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                      },
                      height: 40.kh,
                      width: 124.kw,
                      label: Strings.delete,
                      fontSize: 14.kh,
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      // Get.defaultDialog(
      //   title: "Delete Account",
      //   middleText: "Are you sure you want to delete your account?",
      //   textCancel: "Cancel",
      //   textConfirm: "Delete",
      //   confirmTextColor: Colors.white,
      //   onConfirm: () async {
      //     final res = await APIManager.deleteAccount();
      //     PushNotificationService.unsubFcm(
      //         "${Get.find<HomeController>().userInfo.value.data?.Id}");
      //     Get.find<AuthService>().logOutUser();
      //     Get.find<HomeController>().userInfoAPI();
      //     Get.find<HomeController>().changeTabIndex(0);
      //     Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      //   },
      //   onCancel: () {
      //     Get.back(); // Close the dialog
      //   },
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String? validateCity(Object? value) {
    if (value == null) {
      return 'Please select your city';
    }
    return null;
  }

  void addCityNames(String value) {
    if (value.isEmpty || value == "") {
      cityNames.value = CityList.cityNames;
    } else {
      isCityListExpanded.value = true;
      cityNames.value = CityList.cityNames.where((city) {
        return city.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }
}

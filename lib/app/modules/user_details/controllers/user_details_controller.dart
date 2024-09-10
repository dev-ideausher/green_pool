import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
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
  TextEditingController nameTextController =
      TextEditingController(text: Get.find<GetStorageService>().getUserName);
  TextEditingController emailTextController =
      TextEditingController(text: Get.find<GetStorageService>().emailId);
  TextEditingController phoneTextController =
      TextEditingController(text: Get.find<GetStorageService>().phoneNumber);
  TextEditingController city =
      TextEditingController(text: Get.find<GetStorageService>().city);
  TextEditingController genderTextController =
      TextEditingController(text: Get.find<GetStorageService>().gender);
  TextEditingController dobTextController =
      TextEditingController(text: Get.find<GetStorageService>().dateOfBirth);
  Rx<File?>? selectedProfileImagePath = Rx<File?>(null);
  Rx<File?>? selectedIDImagePath = Rx<File?>(null);
  RxBool isProfilePicUpdated = false.obs;
  RxBool isIDPicUpdated = false.obs;
  RxBool isCityListExpanded = false.obs;
  RxList<String> cityNames = <String>[].obs;
  RxBool saveBtnLoading = false.obs;

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
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> updateDetailsAPI() async {
    saveBtnLoading.value = true;
    final storageService = Get.find<GetStorageService>();

    final pickedImageFile = selectedProfileImagePath!.value;
    final pickedIDFile = selectedIDImagePath!.value;

    String getMediaType(String? extension) {
      switch (extension) {
        case 'jpg':
        case 'jpeg':
          return 'image/jpeg';
        case 'png':
          return 'image/png';
        default:
          return 'application/octet-stream';
      }
    }

    String profileExtension = pickedImageFile?.path.split('.').last ?? '';
    String idExtension = pickedIDFile?.path.split('.').last ?? '';
    String mediaType = getMediaType(profileExtension);
    String idMediaType = getMediaType(idExtension);

    bool isFullNameEdited = nameTextController.value.text !=
        Get.find<GetStorageService>().getUserName;
    bool isEmailEdited =
        emailTextController.value.text != Get.find<GetStorageService>().emailId;
    bool isCityEdited = city.value.text != Get.find<GetStorageService>().city;
    bool isDOBEdited = dobTextController.value.text !=
        Get.find<GetStorageService>().dateOfBirth;

    Map<String, dynamic> buildFormData() {
      return {
        if (isFullNameEdited) 'fullName': nameTextController.value.text,
        if (isCityEdited) 'city': city.value.text,
        if (isDOBEdited) 'dob': dobTextController.value.text,
        if (isEmailEdited) 'email': emailTextController.value.text,
        if (pickedIDFile != null && isIDPicUpdated.value)
          'idPic': dio.MultipartFile.fromFileSync(
            pickedIDFile.path,
            contentType: MediaType.parse(idMediaType),
            filename: path.basename(pickedIDFile.path),
          ),
        if (pickedImageFile != null && isProfilePicUpdated.value)
          'profilePic': dio.MultipartFile.fromFileSync(
            pickedImageFile.path,
            contentType: MediaType.parse(mediaType),
            filename: path.basename(pickedImageFile.path),
          ),
      };
    }

    try {
      final dio.FormData userData = dio.FormData.fromMap(buildFormData());
      final response = await APIManager.userDetails(body: userData);

      final message = response.data['message'].toString();
      if (response.data['status']) {
        Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
        storageService.profilePicUrl =
            response.data?['data']['profilePic']['url'] ?? "";
        storageService.setUserName = response.data?['data']['fullName'] ?? "";
        storageService.emailId = response.data?['data']['email'] ?? "";
        storageService.city = response.data?['data']['city'] ?? "";
        storageService.dateOfBirth = response.data?['data']['dob'] ?? "";
        storageService.idVerificationPicUrl =
            response.data?['data']['idPic']['url'] ?? "";
        showMySnackbar(msg: message);
      } else {
        showMySnackbar(msg: message);
      }
    } catch (e) {
      log("updateDetailsAPI error: $e");
    } finally {
      saveBtnLoading.value = false;
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
                        Get.find<HomeController>()
                            .userInfo
                            .value
                            .data
                            ?.emergencyContactDetails = [];
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

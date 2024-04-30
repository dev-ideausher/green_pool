import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';
// import '../../profile/controllers/profile_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class UserDetailsController extends GetxController {
  RxString genderValue = "".obs;
  var userInformation = Get.find<HomeController>().userInfo.value.data;
  TextEditingController nameTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.fullName);
  TextEditingController emailTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.email);
  TextEditingController phoneTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.phone);
  TextEditingController cityTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.city);
  TextEditingController genderTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.gender);
  TextEditingController dobTextController = TextEditingController(
      text: Get.find<HomeController>().userInfo.value.data?.dob);
  Rx<File?>? selectedProfileImagePath = Rx<File?>(null);
  Rx<File?>? selectedIDImagePath = Rx<File?>(null);
  RxBool isProfilePicUpdated = false.obs;
  RxBool isIDPicUpdated = false.obs;

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

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
        'city': cityTextController.value.text.isEmpty
            ? userInformation?.city
            : cityTextController.value.text,
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
        'city': cityTextController.value.text.isEmpty
            ? userInformation?.city
            : cityTextController.value.text,
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
        'city': cityTextController.value.text.isEmpty
            ? userInformation?.city
            : cityTextController.value.text,
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
        'city': cityTextController.value.text.isEmpty
            ? userInformation?.city
            : cityTextController.value.text,
        'dob': dobTextController.value.text.isEmpty
            ? userInformation?.dob
            : dobTextController.value.text,
      });
    }

    try {
      final response = await APIManager.userDetails(body: userData);
      showMySnackbar(msg: response.data['message']);
      // Refresh user info after update
      Get.find<HomeController>().userInfoAPI();
      // Navigate back to home screen
      Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      log("updateDetailsAPI error: $e");
    }
  }
}

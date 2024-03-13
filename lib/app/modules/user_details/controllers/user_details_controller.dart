import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../profile/controllers/profile_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class UserDetailsController extends GetxController {
  RxString genderValue = "".obs;
  TextEditingController nameTextController = TextEditingController(
      text: Get.find<ProfileController>().userInfo.value.data?.fullName);
  TextEditingController emailTextController = TextEditingController(
      text: Get.find<ProfileController>().userInfo.value.data?.email);
  TextEditingController cityTextController = TextEditingController(
      text: Get.find<ProfileController>().userInfo.value.data?.city);
  TextEditingController dobTextController = TextEditingController(
      text: Get.find<ProfileController>().userInfo.value.data?.dob);
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
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
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isProfilePicUpdated.value = true;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    final pickedIDFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath.value = File(pickedIDFile.path);
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
    final File pickedImageFile = File(selectedProfileImagePath.value!.path);
    final File pickedIDFile = File(selectedIDImagePath.value!.path);
    String extension = pickedImageFile.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }
    //TODO: only want to update anyone
    final userData = dio.FormData.fromMap({
      'fullName': nameTextController.value.text.isEmpty
          ? Get.find<ProfileController>().userInfo.value.data?.fullName
          : nameTextController.value.text,
      'email': emailTextController.value.text.isEmpty
          ? Get.find<ProfileController>().userInfo.value.data?.email
          : emailTextController.value.text,
      'phone': Get.find<ProfileController>().userInfo.value.data?.phone,
      'gender': genderValue.value == ""
          ? Get.find<ProfileController>().userInfo.value.data?.gender
          : genderValue.value,
      'city': cityTextController.value.text.isEmpty
          ? Get.find<ProfileController>().userInfo.value.data?.city
          : cityTextController.value.text,
      'dob': dobTextController.value.text.isEmpty
          ? Get.find<ProfileController>().userInfo.value.data?.dob
          : dobTextController.value.text,
      'profilePic': isProfilePicUpdated.value
          ? null
          : await dio.MultipartFile.fromFile(
              pickedImageFile.path,
              contentType: MediaType.parse(mediaType),
              filename: path.basename(pickedImageFile.path),
            ),
      'idPic': isIDPicUpdated.value
          ? null
          : await dio.MultipartFile.fromFile(
              pickedIDFile.path,
              contentType: MediaType.parse(mediaType),
              filename: path.basename(pickedIDFile.path),
            ),
    });
    try {
      final responses = await APIManager.userDetails(body: userData);
      showMySnackbar(msg: responses.data['message']);
      //! how will this refresh and the image will display?
      Get.find<HomeController>().userInfoAPI();
      Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      log("updateDetailsAPI error: $e");
    }
  }
}

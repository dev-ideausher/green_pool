import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/rider_profile_setup/views/rider_review_pic.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;

class RiderProfileSetupController extends GetxController {
  RxBool isPicked = false.obs;
  bool isDriver = false;
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isIDPicked = false.obs;
  TextEditingController fullName = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.displayName);
  TextEditingController email = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.email);
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.phoneNumber);
  TextEditingController gender = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

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
  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1950),
        lastDate: DateTime(2025),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = pickedDate.toString().split(" ")[0];
      dateOfBirth.text = formattedDate;
    }
  }

  getProfileImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      update();
      Get.off(RiderReviewPictureView(
        imagePath: selectedProfileImagePath.value!,
      ));
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    final pickedIDFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath.value = File(pickedIDFile.path);
      isIDPicked.value = true;
      Get.back();
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  //
  Future<void> userDetailsAPI() async {
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

    final userData = dio.FormData.fromMap({
      'fullName': fullName.text,
      'email': email.text,
      'phone': phoneNumber.text,
      'gender': gender.text,
      'city': city.text,
      'dob': dateOfBirth.text,
      'profilePic': await dio.MultipartFile.fromFile(
        pickedImageFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedImageFile.path),
      ),
      'idPic': await dio.MultipartFile.fromFile(
        pickedIDFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedIDFile.path),
      ),
    });
    log("profile setup user data: $userData");

    //TODO: how can i save gender and full name to display
    try {
      final responses = await APIManager.userDetails(body: userData);
      showMySnackbar(msg: responses.data['message']);
      Get.find<GetStorageService>().setUserName = fullName.text;
      Get.find<GetStorageService>().setProfileStatus = true;
      if (gender.text == "Female") {
        Get.find<GetStorageService>().setFemale = true;
      } else {
        Get.find<GetStorageService>().setFemale = false;
      }
      // Get.find<GetStorageService>().setProfilePic =
      //     File(selectedProfileImagePath.value!.path);
      showMySnackbar(msg: responses.data['message']);
      Get.offNamed(Routes.MATCHING_RIDES);
    } catch (e) {
      print("userDetailsAPI error: $e");
    }
  }
}

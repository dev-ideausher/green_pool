import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class VehicleDetailsController extends GetxController {
  var vehicleInfoModel =
      Get.find<ProfileController>().userInfo.value.data?.vehicleDetails?[0];
  TextEditingController modelTextController = TextEditingController(
      text: Get.find<ProfileController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.model);
  TextEditingController yearTextController = TextEditingController(
      text: Get.find<ProfileController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.year
          .toString());
  TextEditingController licenseTextController = TextEditingController(
      text: Get.find<ProfileController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.licencePlate);
  RxString vehicletypeValue = "".obs;
  RxString colorValue = "".obs;
  Rx<File?>? selectedVehicleImagePath = Rx<File?>(null);
  RxBool isVehiclePicUpdated = false.obs;

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
      selectedVehicleImagePath!.value = File(pickedFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isVehiclePicUpdated.value = true;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> updateVehicleDetailsAPI() async {
    final File? pickedImageFile = selectedVehicleImagePath!.value;

    String imageExtension = pickedImageFile?.path.split('.').last ?? '';
    String mediaType;

    if (imageExtension == 'jpg' || imageExtension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (imageExtension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }

    dio.FormData userData;

    if (isVehiclePicUpdated.value == true) {
      userData = dio.FormData.fromMap({
        "model": modelTextController.value.text.isEmpty
            ? vehicleInfoModel?.model
            : modelTextController.value.text,
        "type": vehicletypeValue.value == ""
            ? vehicleInfoModel?.type
            : vehicletypeValue.value,
        "color":
            colorValue.value == "" ? vehicleInfoModel?.color : colorValue.value,
        "year": yearTextController.value.text.isEmpty
            ? vehicleInfoModel?.year
            : yearTextController.value.text,
        "licencePlate": licenseTextController.value.text.isEmpty
            ? vehicleInfoModel?.licencePlate
            : licenseTextController.value.text,
        if (pickedImageFile != null)
          'vehiclePic': await dio.MultipartFile.fromFile(
            pickedImageFile.path,
            contentType: MediaType.parse(mediaType),
            filename: path.basename(pickedImageFile.path),
          ),
      });
    } else {
      userData = dio.FormData.fromMap({
        "model": modelTextController.value.text.isEmpty
            ? vehicleInfoModel?.model
            : modelTextController.value.text,
        "type": vehicletypeValue.value == ""
            ? vehicleInfoModel?.type
            : vehicletypeValue.value,
        "color":
            colorValue.value == "" ? vehicleInfoModel?.color : colorValue.value,
        "year": yearTextController.value.text.isEmpty
            ? vehicleInfoModel?.year
            : yearTextController.value.text,
        "licencePlate": licenseTextController.value.text.isEmpty
            ? vehicleInfoModel?.licencePlate
            : licenseTextController.value.text,
      });
    }

    try {
      final response = await APIManager.updateVehicleDetails(body: userData);
      showMySnackbar(msg: response.data['message']);
      // Refresh user info after update
      Get.find<HomeController>().userInfoAPI();
      // Navigate back to home screen
      Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
    } catch (error) {
      throw Exception(error);
    }
  }
}

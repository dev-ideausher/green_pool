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

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class VehicleDetailsController extends GetxController {
  var vehicleInfoModel =
      Get.find<HomeController>().userInfo.value.data?.vehicleDetails?[0];
  TextEditingController modelTextController = TextEditingController(
      text: Get.find<HomeController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.model);
  TextEditingController yearTextController = TextEditingController(
      text: Get.find<HomeController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.year
          .toString());
  TextEditingController licenseTextController = TextEditingController(
      text: Get.find<HomeController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.licencePlate);
  TextEditingController type = TextEditingController(
      text: Get.find<HomeController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.type);
  TextEditingController color = TextEditingController(
      text: Get.find<HomeController>()
          .userInfo
          .value
          .data
          ?.vehicleDetails?[0]
          ?.color);
  Rx<File?>? selectedVehicleImagePath = Rx<File?>(null);
  RxBool isVehiclePicUpdated = false.obs;
  RxBool isTypeListExpanded = false.obs;
  RxList<String> typeList = <String>[
    "Hatchback",
    "Coupe",
    "Convertible",
    "Sedan",
    "SUV",
    "Truck",
    "Van"
  ].obs;
  RxBool isColorListExpanded = false.obs;
  RxList<String> colorList = <String>[
    "Silver",
    "Black",
    "White",
    "Dark Grey",
    "Light Grey",
    "Red",
    "Blue",
    "Light Blue",
    "Dark Blue",
    "Brown"
  ].obs;
  RxBool btnLoading = false.obs;

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
    btnLoading.value = true;
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
        "type":
            type.value.text == "" ? vehicleInfoModel?.type : type.value.text,
        "color":
            color.value.text == "" ? vehicleInfoModel?.color : color.value.text,
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
        "type":
            type.value.text == "" ? vehicleInfoModel?.type : type.value.text,
        "color":
            color.value.text == "" ? vehicleInfoModel?.color : color.value.text,
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
      showMySnackbar(msg: response.data['message'].toString());
      // Refresh user info after update
      Get.find<HomeController>().changeTabIndex(0);
      Get.find<HomeController>().userInfoAPI();
      // Navigate back to home screen
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      btnLoading.value = false;
    } catch (error) {
      btnLoading.value = false;
      throw Exception(error);
    }
  }
}

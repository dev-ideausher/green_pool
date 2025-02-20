import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_pages.dart';
import '../../../services/image_helper.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

class VehicleDetailsController extends GetxController {
  TextEditingController modelTextController =
      TextEditingController(text: Get.find<GetStorageService>().vehicleModel);
  TextEditingController yearTextController =
      TextEditingController(text: Get.find<GetStorageService>().vehicleYear);
  TextEditingController licenseTextController =
      TextEditingController(text: Get.find<GetStorageService>().licensePlate);
  TextEditingController type =
      TextEditingController(text: Get.find<GetStorageService>().vehicleType);
  TextEditingController color =
      TextEditingController(text: Get.find<GetStorageService>().vehicleColor);
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
  RxBool isBtnActive = false.obs;

  Rx<File?> selectedIDImagePath = Rx<File?>(null);
  RxBool isIDPicUpdated = false.obs;

  getVehicleImage(ImageSource imageSource) async {
    XFile? pickedFile =
        await ImageUtil.cropCompressImage(imageSource: imageSource);
    if (pickedFile != null) {
      selectedVehicleImagePath!.value = File(pickedFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isVehiclePicUpdated.value = true;
      isBtnActive.value = true;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  getIDImage(ImageSource imageSource) async {
    XFile? pickedIDFile =
        await ImageUtil.cropCompressImage(imageSource: imageSource);
    if (pickedIDFile != null) {
      selectedIDImagePath!.value = File(pickedIDFile.path);
      showMySnackbar(msg: 'Image selected');
      update();
      isIDPicUpdated.value = true;
      isBtnActive.value = true;
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  updateData() async {
    if (selectedIDImagePath.value != null) {
      await updateID();
    } else {
      await updateVehicleDetailsAPI();
    }
  }

  Future<void> updateID() async {
    final File pickedIDFile = File(selectedIDImagePath.value?.path ?? "");
    String idExtension = pickedIDFile.path.split('.').last;
    String idMediaType;

    if (idExtension == 'jpg' || idExtension == 'jpeg') {
      idMediaType = 'image/jpeg';
    } else if (idExtension == 'png') {
      idMediaType = 'image/png';
    } else {
      idMediaType = 'application/octet-stream';
    }

    final userData = dio.FormData.fromMap({
      'idPic': await dio.MultipartFile.fromFile(
        pickedIDFile.path,
        contentType: MediaType.parse(idMediaType),
        filename: path.basename(pickedIDFile.path),
      )
    });

    try {
      btnLoading.value = true;
      final response = await APIManager.userDetails(body: userData);
      if (response.data['status'] == true) {
        await updateVehicleDetailsAPI();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
        btnLoading.value = false;
      }
    } catch (e) {
      btnLoading.value = false;
      throw Exception(e);
    }
  }

  Future<void> updateVehicleDetailsAPI() async {
    final storageService = Get.find<GetStorageService>();
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
            ? storageService.vehicleModel
            : modelTextController.value.text,
        "type": type.value.text == ""
            ? storageService.vehicleType
            : type.value.text,
        "color": color.value.text == ""
            ? storageService.vehicleColor
            : color.value.text,
        "year": yearTextController.value.text.isEmpty
            ? storageService.vehicleYear
            : yearTextController.value.text,
        "licencePlate": licenseTextController.value.text.isEmpty
            ? storageService.licensePlate
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
            ? storageService.vehicleModel
            : modelTextController.value.text,
        "type": type.value.text == ""
            ? storageService.vehicleType
            : type.value.text,
        "color": color.value.text == ""
            ? storageService.vehicleColor
            : color.value.text,
        "year": yearTextController.value.text.isEmpty
            ? storageService.vehicleYear
            : yearTextController.value.text,
        "licencePlate": licenseTextController.value.text.isEmpty
            ? storageService.licensePlate
            : licenseTextController.value.text,
      });
    }

    try {
      final response = await APIManager.updateVehicleDetails(body: userData);
      showMySnackbar(msg: response.data['message'].toString());
      // Refresh user info after update
      Get.find<HomeController>().userInfoAPI();
      // Navigate back to home screen
      Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
      btnLoading.value = false;
    } catch (error) {
      btnLoading.value = false;
      throw Exception(error);
    }
  }
}

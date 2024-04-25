import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class SubmitDisputeController extends GetxController {
  String? bookingId = "";
  Rx<File?> selectedImagePath = Rx<File?>(null);
  RxBool isImageSelected = false.obs;
  TextEditingController descriptionTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    bookingId = Get.arguments;
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = File(pickedFile.path);
      isImageSelected.value = true;
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> fileDisputeAPI() async {
    final File pickedImageFile = File(selectedImagePath.value!.path);
    String extension = pickedImageFile.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }

    final disputeData = dio.FormData.fromMap({
      'ridePostId': bookingId,
      'description': descriptionTextController.value.text,
      'fileDisputePic': await dio.MultipartFile.fromFile(
        pickedImageFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedImageFile.path),
      ),
    });

    try {
      final response = await APIManager.postFileDispute(body: disputeData);
      var data = jsonDecode(response.toString());
      showMySnackbar(msg: data['message']);
      Get.until((route) => Get.currentRoute == Routes.FILE_DISPUTE);
    } catch (e) {
      throw Exception(e);
    }
  }
}

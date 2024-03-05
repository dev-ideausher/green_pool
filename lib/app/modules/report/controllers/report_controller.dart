import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

class ReportController extends GetxController {
  Rx<File?> uploadedPic = Rx<File?>(null);
  TextEditingController bugController = TextEditingController();
  RxBool picUploaded = false.obs;

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

  getBugImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      uploadedPic.value = File(pickedFile.path);
      picUploaded.value = true;
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> bugReportAPI() async {
    final File pickedBugImage = File(uploadedPic.value!.path);
    String extension = pickedBugImage.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }

    final bugReportData = dio.FormData.fromMap({
      'bugDescription': bugController.text,
      'bugPic': await dio.MultipartFile.fromFile(
        pickedBugImage.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedBugImage.path),
      )
    });

    try {
      final responses = await APIManager.postBugReport(body: bugReportData);
      showMySnackbar(msg: responses.data['message']);
    } catch (error) {
      log("bugReportAPI error: $error");
    }
  }
}

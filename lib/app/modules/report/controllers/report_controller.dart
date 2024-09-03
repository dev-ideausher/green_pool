import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;

import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';

class ReportController extends GetxController {
  // Rx<File?> uploadedPic = Rx<File?>(null);
  RxList<File> selectedImages = RxList<File>([]);
  TextEditingController bugController = TextEditingController();
  RxBool picUploaded = false.obs;
  RxBool isActive = false.obs;

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
  handleButtonState(String value) {
    if (value.isNotEmpty || value != "") {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  getBugImage(ImageSource imageSource) async {
    final List<XFile>? pickedFiles = await GpUtil.compressImages(
        imageSource); // Ensure this method returns a list of XFile
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.value =
          pickedFiles.map((file) => File(file.path)).toList();
      showMySnackbar(msg: '${pickedFiles.length} image(s) selected');
      picUploaded.value = true;
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> bugReportAPI() async {
    dio.FormData bugReportData;

    if (picUploaded.value) {
      List<dio.MultipartFile> imageFiles = [];
      for (File image in selectedImages) {
        String extension = image.path.split('.').last;
        String mediaType;

        if (extension == 'jpg' || extension == 'jpeg') {
          mediaType = 'image/jpeg';
        } else if (extension == 'png') {
          mediaType = 'image/png';
        } else {
          mediaType = 'application/octet-stream';
        }

        imageFiles.add(await dio.MultipartFile.fromFile(
          image.path,
          contentType: MediaType.parse(mediaType),
          filename: path.basename(image.path),
        ));
      }

      bugReportData = dio.FormData.fromMap({
        'bugDescription': bugController.value.text,
        'bugPic': imageFiles,
      });
    } else {
      bugReportData = dio.FormData.fromMap(
          {'bugDescription': bugController.value.text, 'bugPic': []});
    }

    try {
      final responses = await APIManager.postBugReport(body: bugReportData);
      Get.back();
      showMySnackbar(
          msg:
              "Thankyou for giving a feedback, our team will get back to you soon!");
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/gp_util.dart';
import '../../../services/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ffi';

import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class SubmitDisputeController extends GetxController {
  String? bookingId = "";
  RxList<File> selectedImages = RxList<File>([]);
  RxBool isImageSelected = false.obs;
  RxBool isActive = false.obs;
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
  handleButtonState(String value) {
    if (value.isNotEmpty || value != "") {
      isActive.value = true;
    } else {
      isActive.value = false;
    }
  }

  getImage(ImageSource imageSource) async {
    final List<XFile>? pickedFiles = await GpUtil.compressImages(
        imageSource); // Ensure this method returns a list of XFile
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.value =
          pickedFiles.map((file) => File(file.path)).toList();
      showMySnackbar(msg: '${pickedFiles.length} image(s) selected');
      isImageSelected.value = true;
      update();
    } else {
      showMySnackbar(msg: 'No image selected');
    }
  }

  Future<void> fileDisputeAPI() async {
    dio.FormData disputeData;

    if (isImageSelected.value) {
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

      disputeData = dio.FormData.fromMap({
        'ridePostId': bookingId,
        'description': descriptionTextController.value.text,
        'fileDisputePic': imageFiles
      });
    } else {
      disputeData = dio.FormData.fromMap({
        'ridePostId': bookingId,
        'description': descriptionTextController.value.text,
        'fileDisputePic': []
      });
    }

    try {
      final response = await APIManager.postFileDispute(body: disputeData);
      if (response.data["status"]) {
        Get.until((route) => Get.currentRoute == Routes.FILE_DISPUTE);
        showMySnackbar(msg: response.data['message'].toString());
      } else {
        showMySnackbar(msg: response.data['message'].toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

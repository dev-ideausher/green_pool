import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/file_dispute_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';

class FileDisputeController extends GetxController {
  RxBool isLoading = true.obs;
  var fileDisputeModel = FileDisputeModel().obs;

  TextEditingController bookingTextController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await fileDisputeAPI();
  }

  fileDisputeAPI() async {
    try {
      isLoading.value = true;
      final response = await APIManager.getFileDisputeRides();
      var data = jsonDecode(response.toString());
      fileDisputeModel.value = FileDisputeModel.fromJson(data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  void moveToSubmitDispute(String rideId) {
    Get.toNamed(Routes.SUBMIT_DISPUTE, arguments: rideId)?.then(
      (value) => fileDisputeAPI(),
    );
  }
}

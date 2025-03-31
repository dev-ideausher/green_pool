import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_history.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../services/dio/api_service.dart';

class PreviousRidesController extends GetxController {
  RxBool isLoading = true.obs;

  var driverHist = DriverHistory().obs;
  RxString driverId = "".obs;
  RxString driverName = "".obs;

  @override
  void onInit() {
    super.onInit();

    driverName.value = Get.arguments["driverName"];
    driverId.value = Get.arguments["driverId"];
    driverHistory(driverId.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> driverHistory(String? driverId) async {
    if (driverId == null || driverId == "") {
      return;
    }

    try {
      final res = await APIManager.getDriverHistory(driverId: driverId);
      var data = jsonDecode(res.toString());
      driverHist.value = DriverHistory.fromJson(data);
      if (driverHist.value.status != true) {
        showMySnackbar(
            msg: res.data["message"] ?? LocaleKeys.app_somethingWentWrong.tr);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}

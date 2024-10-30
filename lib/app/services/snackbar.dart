import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showMySnackbar({String? title, required String msg}) {
  Get.isSnackbarOpen == true
      ? null
      : Get.rawSnackbar(
          title: title,
          message: msg,
          duration: const Duration(milliseconds: 2000),
          borderRadius: 8,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12));
}

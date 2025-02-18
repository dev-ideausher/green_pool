import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/storage.dart';

class LanguageController extends GetxController {
  final List languages = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Spanish', 'locale': const Locale('es', 'ES')},
    {'name': 'French', 'locale': const Locale('fr', 'FR')},
  ];

  changeLanguage(Locale locale) {
    Get.find<GetStorageService>().appLocale = locale;
  }
}

  /*@override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }*/

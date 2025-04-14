import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../services/app_language.dart';

class LanguageController extends GetxController {
  // final List languages = [
  //   {'name': 'English', 'locale': const Locale('en', 'US')},
  //   {'name': 'Spanish', 'locale': const Locale('es', 'ES')},
  //   {'name': 'French', 'locale': const Locale('fr', 'FR')},
  // ];
  List<LanguageModel> languages = <LanguageModel>[];
  RxString selectedLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = Get.find<GetStorageService>().langCode;
    languages = getLanguages();
  }

  // changeLanguage(Locale locale) {
  //   Get.find<GetStorageService>().appLocale = locale;
  // }

  getLanguages() => [
        LanguageModel(Languages.ENGLISH, Languages.EN, Languages.ENV),
        LanguageModel(Languages.FRENCH, Languages.FR, Languages.FRV),
        LanguageModel(Languages.SPANISH, Languages.ES, Languages.ESV),
      ];

  void changeLanguage(LanguageModel language) {
    if (selectedLanguage.value != language.code) {
      selectedLanguage(language.code);
      Get.find<GetStorageService>().langCode = language.code;
      Get.find<GetStorageService>().langCodeV = language.codeV;
      Get.updateLocale(Locale(language.code, language.codeV));
    }
  }
}

  /*

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }*/

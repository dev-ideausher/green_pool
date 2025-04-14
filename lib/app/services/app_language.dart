import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import 'storage.dart';

class AppLanguage {
  static getLocale() {
    String langCode = Get.find<GetStorageService>().langCode;

    switch (langCode) {
      case Languages.EN:
        return const Locale(Languages.EN, Languages.ENV);
      // case Languages.AR:
      //   return const Locale(Languages.AR, Languages.ARV);
      // case Languages.IT:
      //   return const Locale(Languages.IT, Languages.ITV);
      // case Languages.GR:
      //   return const Locale(Languages.GR, Languages.GRV);
      case Languages.FR:
        return const Locale(Languages.FR, Languages.FRV);
      case Languages.ES:
        return const Locale(Languages.ES, Languages.ESV);
      default:
        return const Locale(Languages.EN, Languages.ENV);
    }
  }

  static String getCurrnentLanguage() {
    return Get.find<GetStorageService>().langCode == "en"
        ? LocaleKeys.app_english.tr
        : Get.find<GetStorageService>().langCode == "es" ? LocaleKeys.app_spanish.tr :  LocaleKeys.app_french.tr;
  }
}

// ignore_for_file: constant_identifier_names

class Languages {
  static const String ENGLISH = "English";
  static const String EN = "en";
  static const String ENV = "US";

  static const String SPANISH = "Spanish";
  static const String ES = "es";
  static const String ESV = "ES";

  static const String FRENCH = "French";
  static const String FR = "fr";
  static const String FRV = "FR";

  // static const String ARABIC = "Arabic";
  // static const String AR = "ar";
  // static const String ARV = "DZ";

  // static const String ITALIAN = "Italian";
  // static const String IT = "it";
  // static const String ITV = "IT";

  // static const String GERMAN = "German";
  // static const String GR = "de";
  // static const String GRV = "DE";
}

class LanguageModel {
  String country;
  String code;
  String codeV;
  String? iconPath;
  LanguageModel(this.country, this.code, this.codeV, {this.iconPath});
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/app_language.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_language.tr),
        ),
        body: Column(
          children: [
            _langTile(
                isPinkModeOn,
                LanguageModel(
                    LocaleKeys.app_english.tr, Languages.EN, Languages.ENV),
                selected: controller.selectedLanguage.value == Languages.EN,
                onTap: () {
              controller.changeLanguage(LanguageModel(
                  LocaleKeys.app_english.tr, Languages.EN, Languages.ENV));
            }).paddingSymmetric(vertical: 4.kh),
            _langTile(
                isPinkModeOn,
                LanguageModel(
                    LocaleKeys.app_french.tr, Languages.FR, Languages.FRV),
                selected: controller.selectedLanguage.value == Languages.FR,
                onTap: () {
              controller.changeLanguage(LanguageModel(
                  LocaleKeys.app_french.tr, Languages.FR, Languages.FRV));
            }).paddingSymmetric(vertical: 4.kh),
            _langTile(
                isPinkModeOn,
                LanguageModel(
                    LocaleKeys.app_spanish.tr, Languages.ES, Languages.ESV),
                selected: controller.selectedLanguage.value == Languages.ES,
                onTap: () {
              controller.changeLanguage(LanguageModel(
                  LocaleKeys.app_spanish.tr, Languages.ES, Languages.ESV));
            }).paddingSymmetric(vertical: 4.kh),
          ],
        ));
  }

  ListTile _langTile(bool isPinkModeOn, LanguageModel language,
      {bool selected = true, Function()? onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        language.country,
        style: TextStyleUtil.k14Bold(),
      ),
      tileColor: selected
          ? isPinkModeOn
              ? ColorUtil.kPrimary4PinkMode
              : ColorUtil.kPrimary01
          : ColorUtil.kWhiteColor,
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';

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
        body: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => controller
                    .changeLanguage(controller.languages[index]['locale']),
                title: Text(controller.languages[index]['name']),
                tileColor: controller.languages[index]['locale'] ==
                        Get.find<GetStorageService>().appLocale
                    ? isPinkModeOn
                        ? ColorUtil.kPrimary4PinkMode
                        : ColorUtil.kPrimary01
                    : ColorUtil.kWhiteColor,
              ).paddingSymmetric(vertical: 4.kh);
            },
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount: controller.languages.length));
  }
}

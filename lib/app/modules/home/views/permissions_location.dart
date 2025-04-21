import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/storage.dart';
import '../controllers/home_controller.dart';

class PermissionsLocation extends GetView<HomeController> {
  const PermissionsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          200.kheightBox,
          Center(
            child: Image.asset(
              ImageConstant.gifLocation,
              height: 200.kh,
              width: 200.kw,
            ),
          ),
          Text(
            LocaleKeys.app_enableLocation.tr,
            style: TextStyleUtil.k24Heading600(),
          ).paddingOnly(bottom: 8.kh),
          Text(
            LocaleKeys.app_allowLocationAccess.tr,
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
            textAlign: TextAlign.center,
          ).paddingOnly(bottom: 8.kh, left: 16.kw, right: 16.kw),
          const Expanded(child: SizedBox()),
          Center(
            child: GreenPoolButton(
              onPressed: () {
                Get.back();
                controller.determinePosition();
                Get.find<GetStorageService>().hasTappedAllowLocation = true;
              },
              label: LocaleKeys.app_continueText.tr,
            ).paddingSymmetric(vertical: 40.kh),
          ),
        ],
      ),
    );
  }
}

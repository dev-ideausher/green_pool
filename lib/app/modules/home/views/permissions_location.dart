import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

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
            Strings.enableLocation,
            style: TextStyleUtil.k24Heading600(),
          ).paddingOnly(bottom: 8.kh),
          Text(
            Strings.allowLocationAccess,
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
            textAlign: TextAlign.center,
          ).paddingOnly(bottom: 8.kh),
          const Expanded(child: SizedBox()),
          Center(
            child: GreenPoolButton(
              onPressed: () {
                controller.determinePosition();
              },
              label: Strings.allowAccess,
            ).paddingSymmetric(vertical: 40.kh),
          ),
        ],
      ),
    );
  }
}

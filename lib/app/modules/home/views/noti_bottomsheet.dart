import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/home_controller.dart';

class NotificationBottomSheet extends GetView<HomeController> {
  const NotificationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.kh),
      decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.kh),
              topRight: Radius.circular(24.kh))),
      child: Column(
        children: [
          Text(
            "Enable Notifications",
            style: TextStyleUtil.k18Heading600(),
          ),
          CommonImageView(
            svgPath: ImageConstant.svgEnableNotification,
          ).paddingSymmetric(vertical: 64.kh),
          Text(
            "Don’t let any ride slip away.\nEnable notifications for interactive experiences\nand real-time engagement.",
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
            textAlign: TextAlign.center,
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () async {
              await controller.setupMessage();
              Get.back();
            },
            label: "Enable Notifications",
          ).paddingOnly(bottom: 16.kh),
        ],
      ),
    );
  }
}

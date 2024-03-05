import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../controllers/profile_setup_controller.dart';

class ReviewPictureView extends GetView<ProfileSetupController> {
  final File imagePath;
  const ReviewPictureView({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(ImageConstant.svgIconBack30),
            ).paddingOnly(top: 16.kh, bottom: 8.kh),
            Text(
              'Review Picture',
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'Please review your picture and make sure that people can clearly see your face.',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 74.kh),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(100.kh),
                    child: Image.file(imagePath),
                  ),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () {
                Get.until((route) => Get.currentRoute == Routes.PROFILE_SETUP);
                controller.isProfileImagePicked.value = true;
              },
              label: 'Done',
            ),
            GreenPoolButton(
              onPressed: () => Get.back(),
              isBorder: true,
              borderColor: ColorUtil.kSecondary01,
              label: 'Retake photo',
              labelColor: ColorUtil.kSecondary01,
              borderWidth: 2.kh,
            ).paddingOnly(top: 16.kh, bottom: 24.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

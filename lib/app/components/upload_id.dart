import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../constants/image_constant.dart';
import '../services/colors.dart';
import '../services/custom_button.dart';
import '../services/text_style_util.dart';

class UploadIDView extends StatelessWidget {
  final Function()? onPressedSelfie, onPressedGallery;
  const UploadIDView(
      {super.key,
      required this.onPressedSelfie,
      required this.onPressedGallery});

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
              'Upload ID',
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'Take a new photo or upload from your gallery\nto set up your profile picture.',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 74.kh),
            Center(
              child: Column(children: [
                //Image
                SvgPicture.asset(ImageConstant.svgAddID)
                    .paddingOnly(bottom: 54.kh),

                Text(
                  "Place ID on a plain dark surface and make sure\nall four corners are visible.",
                  style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: onPressedSelfie ?? () {},
              color: ColorUtil.kPrimary01,
              label: 'Click a photo',
            ),
            GreenPoolButton(
               onPressed: onPressedGallery ?? () {},
              isBorder: true,
              borderColor: ColorUtil.kSecondary01,
              label: 'Choose from library',
              labelColor: ColorUtil.kSecondary01,
              borderWidth: 2.kh,
            ).paddingOnly(top: 16.kh, bottom: 24.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

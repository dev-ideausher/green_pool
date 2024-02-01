import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../constants/image_constant.dart';
import '../modules/rider_profile_setup/controllers/rider_profile_setup_controller.dart';

class AddPictureView extends StatelessWidget {
  final Function()? onPressedSelfie, onPressedGallery;
  const AddPictureView(
      {super.key, this.onPressedSelfie, this.onPressedGallery});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>RiderProfileSetupController());
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
              'Add Picture',
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'Take a new photo or upload from your gallery to set up your profile picture.',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 74.kh),
            Center(
              child: Column(children: [
                //Image
                SvgPicture.asset(ImageConstant.svgAddPicture)
                    .paddingOnly(bottom: 54.kh),

                Text(
                  "Make sure your face has to be well lit and you\ndon't have any background light and\ndistractions.",
                  style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: onPressedSelfie ?? () {},
              color: ColorUtil.kPrimary01,
              label: 'Take Selfie',
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

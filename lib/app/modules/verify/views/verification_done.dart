import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/verify_controller.dart';

class VerificationDone extends GetView<VerifyController> {
  const VerificationDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 500.kh,
                  width: 100.w,
                ),
                // SvgPicture.asset(ImageConstant.svgConfetti),
                SvgPicture.asset(
                  ImageConstant.svgCompleteTick,
                  height: 110.kh,
                  width: 110.kw,
                ),
                Positioned(
                  top: 390.kh,
                  child: Text(
                    "Woohoo!",
                    style: TextStyleUtil.k24Heading700(),
                  ),
                ),
                Positioned(
                    top: 440.kh,
                    child: Text(
                      "Verification is successful!\nPlease continue to your profile.",
                      style:
                          TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () {
              controller.createAccData.isDriver!
                  ? Get.toNamed(Routes.PROFILE_SETUP)
                  : Get.toNamed(Routes.RIDER_PROFILE_SETUP);
            },
            label: "Continue",
          ).paddingOnly(bottom: 40.kh),
        ],
      ),
    ));
  }
}

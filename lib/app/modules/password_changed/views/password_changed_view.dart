import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/reset_password/controllers/reset_password_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';

class PasswordChanged extends GetView<ResetPasswordController> {
  const PasswordChanged({super.key});

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
                    "Password Changed!",
                    style: TextStyleUtil.k24Heading700(),
                  ),
                ),
                Positioned(
                    top: 430.kh,
                    child: Text(
                      "Password changed successfully!",
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
              Get.until((route) => Get.currentRoute == Routes.LOGIN);
            },
            label: "Login",
          ).paddingOnly(bottom: 40.kh),
        ],
      ),
    ));
  }
}

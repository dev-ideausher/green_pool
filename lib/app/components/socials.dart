import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../constants/image_constant.dart';
import '../services/colors.dart';

class Socials extends StatelessWidget {
  final Function()? onPressedGoogle, onPressedFacebook, onPressedApple;
  const Socials({
    super.key,
    this.onPressedGoogle,
    this.onPressedFacebook,
    this.onPressedApple,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPressedGoogle ?? () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.kh),
                side: const BorderSide(color: ColorUtil.kBlack07)),
            padding: EdgeInsets.symmetric(horizontal: 40.kw, vertical: 12.kh),
            shadowColor: Colors.transparent,
            backgroundColor: ColorUtil.kBackgroundColor,
            foregroundColor: ColorUtil.kBlack07,
            surfaceTintColor: ColorUtil.kBackgroundColor,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
          ),
          child: SvgPicture.asset(
            ImageConstant.svgGoogle,
            height: 24.kh,
            width: 24.kw,
          ),
        ),
        ElevatedButton(
          onPressed: onPressedFacebook ?? () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.kh),
                side: const BorderSide(color: ColorUtil.kBlack07)),
            padding: EdgeInsets.symmetric(horizontal: 40.kw, vertical: 12.kh),
            shadowColor: Colors.transparent,
            backgroundColor: ColorUtil.kBackgroundColor,
            foregroundColor: ColorUtil.kBlack07,
            surfaceTintColor: ColorUtil.kBackgroundColor,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
          ),
          child: SvgPicture.asset(
            ImageConstant.svgFacebook,
            height: 24.kh,
            width: 24.kw,
          ),
        ).paddingSymmetric(horizontal: 16.kw),
        ElevatedButton(
          onPressed: onPressedApple ?? () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.kh),
                side: const BorderSide(color: ColorUtil.kBlack07)),
            padding: EdgeInsets.symmetric(horizontal: 40.kw, vertical: 12.kh),
            shadowColor: Colors.transparent,
            backgroundColor: ColorUtil.kBackgroundColor,
            foregroundColor: ColorUtil.kBlack07,
            surfaceTintColor: ColorUtil.kBackgroundColor,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
          ),
          child: SvgPicture.asset(
            ImageConstant.svgApple,
            height: 24.kh,
            width: 24.kw,
          ),
        ),
      ],
    );
  }
}

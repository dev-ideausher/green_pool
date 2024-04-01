import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class GetStartedView extends GetView {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SvgPicture.asset(
            ImageConstant.svgGetStarted,
            height: 348.kh,
            width: 348.kw,
          ),
        ).paddingOnly(bottom: 3.kh),
        Text(
          "Save money ,\nShare rides &\nSocialize",
          style: TextStyleUtil.k32Heading700(),
        ).paddingOnly(bottom: 14.kh),
        Text(
          "Let's make environment greener and\ncommuting smarter together!",
          style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
        )
      ],
    ).paddingSymmetric(horizontal: 20.kw);
  }
}

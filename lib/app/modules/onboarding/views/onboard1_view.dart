import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

class Onboard1View extends GetView {
  const Onboard1View({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          ImageConstant.svgOnboard1,
          height: 348.kh,
          width: 348.kw,
        ).paddingOnly(bottom: 3.kh),
        Text(
          'Lorem ipsum dolor sit amet consectetur.',
          style: TextStyleUtil.k24Heading700(),
          textAlign: TextAlign.center,
        ).paddingOnly(bottom: 16.kh),
        Text(
          'Torem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
          style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
          textAlign: TextAlign.center,
        )
      ],
    ).paddingSymmetric(horizontal: 20.kw);
  }
}

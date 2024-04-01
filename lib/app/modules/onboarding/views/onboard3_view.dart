import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class Onboard3View extends GetView {
  const Onboard3View({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          ImageConstant.svgOnboard3,
          height: 348.kh,
          width: 348.kw,
        ).paddingOnly(bottom: 3.kh),
        Text(
          'Seamless ride sharing platform.',
          style: TextStyleUtil.k24Heading700(),
          textAlign: TextAlign.center,
        ).paddingOnly(bottom: 16.kh),
        Text(
          'Discover seamless Carpooling trip searches\nand rides with our unique features.\nExplore now.',
          style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
          textAlign: TextAlign.center,
        ),
      ],
    ).paddingSymmetric(horizontal: 20.kw);
  }
}

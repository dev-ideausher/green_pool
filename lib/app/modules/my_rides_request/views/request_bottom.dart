import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';

class RequestBottom extends StatelessWidget {
  const RequestBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.kh),
        width: 100.w,
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.requestSent,
              style: TextStyleUtil.k18Heading600(),
            ).paddingOnly(bottom: 24.kh),
            SvgPicture.asset(
              ImageConstant.svgCompleteTick,
              height: 64.kh,
              width: 64.kw,
            ).paddingOnly(bottom: 16.kh),
            Text(
              Strings.requestSentToRider,
              textAlign: TextAlign.center,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(bottom: 40.kh),
            GreenPoolButton(
                label: Strings.continueText,
                onPressed: () {
                  Get.back();
                }).paddingOnly(bottom: 16.kh),
            /*GreenPoolButton(
                label: Strings.cancelRequest,
                isBorder: true,
                onPressed: () {
                  Get.until(
                      (route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                }),*/
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';

class CreateRideAlertBottomsheet extends StatelessWidget {
  const CreateRideAlertBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                    padding: EdgeInsets.all(24.kh),
                    height: 390.kh,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorUtil.kWhiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.kh),
                            topRight: Radius.circular(40.kh))),
                    child: Column(
                      children: [
                        Text(
                          Strings.requestAlertCreatedSuccessfully,
                          style: TextStyleUtil.k18Heading600(),
                          textAlign: TextAlign.center,
                        ).paddingOnly(bottom: 24.kh),
                        SvgPicture.asset(
                          ImageConstant.svgCompleteTick,
                          height: 64.kh,
                          width: 64.kw,
                        ).paddingOnly(bottom: 16.kh),
                        Text(
                          Strings.rideAlertCreatedSuccessfully,
                          textAlign: TextAlign.center,
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          Strings.theMatchingRideAlertWillBeSentToYouShortly,
                          textAlign: TextAlign.center,
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 40.kh),
                        GreenPoolButton(
                            label: Strings.continueText,
                            onPressed: () {
                              Get.until((route) =>
                                  Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                            }),
                      ],
                    ));
  }
}
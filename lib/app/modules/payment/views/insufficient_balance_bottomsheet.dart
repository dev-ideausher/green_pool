import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';

class InsufficientBalanceSheet extends StatelessWidget {
  const InsufficientBalanceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.kh),
      height: 350.kh,
      decoration: BoxDecoration(
        color: ColorUtil.kWhiteColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.kh), topRight: Radius.circular(40.kh)),
      ),
      child: Column(
        children: [
          Text(Strings.insufficientBalance,
                  style: TextStyleUtil.k18Heading600())
              .paddingOnly(bottom: 24.kh),
          CommonImageView(
            svgPath: ImageConstant.svgCross,
            height: 64.kh,
            width: 64.kw,
          ).paddingOnly(bottom: 16.kh),
          Text(Strings.paymentUnsuccessful,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              textAlign: TextAlign.center),
          GreenPoolButton(
            onPressed: () {
              Get.toNamed(Routes.WALLET);
            },
            label: Strings.addMoneyToWallet,
          ).paddingOnly(top: 40.kh),
        ],
      ),
    );
  }
}

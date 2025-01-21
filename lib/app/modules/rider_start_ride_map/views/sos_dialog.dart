import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';

class SosDialog extends StatelessWidget {
  const SosDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.kh),
        height: 50.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.circular(8.kh),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.app_sendingSOS.tr,
              style: TextStyleUtil.k24Heading700(),
              textAlign: TextAlign.center,
            ).paddingSymmetric(vertical: 4.kh),
            SizedBox(),
            Text(
              LocaleKeys.app_sosMessage.tr,
              style: TextStyleUtil.k14Regular(
                color: ColorUtil.kBlack04,
              ),
              textAlign: TextAlign.center,
            ).paddingOnly(bottom: 40.kh),
            GreenPoolButton(onPressed: () {}, height: 40.kh, width: 60.w, label: LocaleKeys.app_cancel.tr, fontSize: 14.kh, padding: const EdgeInsets.all(8)),
          ],
        ),
      ),
    );
  }
}

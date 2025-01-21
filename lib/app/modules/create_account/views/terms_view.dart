import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/create_account_controller.dart';

class TermsView extends GetView<CreateAccountController> {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.app_termsAndConditions.tr,
            style: TextStyleUtil.k32Heading700(),
          ).paddingOnly(bottom: 4.kh),
          Text(
            LocaleKeys.app_agreeToTermsAndConditions.tr,
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
          ).paddingOnly(bottom: 32.kh),
          Text(
            LocaleKeys.app_loremText.tr,
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

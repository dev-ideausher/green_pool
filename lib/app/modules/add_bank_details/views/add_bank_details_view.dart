import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/custom_button.dart';
import '../controllers/add_bank_details_controller.dart';

class AddBankDetailsView extends GetView<AddBankDetailsController> {
  const AddBankDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_payment.tr),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.app_enterAccDetails.tr,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Text(
              LocaleKeys.app_accHolderName.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: LocaleKeys.app_enterName.tr)
                .paddingOnly(bottom: 16.kh),
            Text(
              LocaleKeys.app_accNumber.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: LocaleKeys.app_enterNumber.tr)
                .paddingOnly(bottom: 16.kh),
            Text(
              LocaleKeys.app_transitNumber.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: LocaleKeys.app_enterNumber.tr)
                .paddingOnly(bottom: 16.kh),
            Text(
              LocaleKeys.app_institutionNumber.tr,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: LocaleKeys.app_enterNumber.tr)
                .paddingOnly(bottom: 16.kh),
            const Expanded(child: SizedBox()),
            Obx(
              () => GreenPoolButton(
                onPressed: () {},
                label: LocaleKeys.app_send.tr,
                isActive: controller.buttonState.value,
              ).paddingSymmetric(vertical: 40.kh),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

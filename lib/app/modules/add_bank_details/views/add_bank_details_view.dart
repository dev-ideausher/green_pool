import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../services/custom_button.dart';
import '../controllers/add_bank_details_controller.dart';

class AddBankDetailsView extends GetView<AddBankDetailsController> {
  const AddBankDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(Strings.payment),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.enterAccDetails,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Text(
              Strings.accHolderName,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterName)
                .paddingOnly(bottom: 16.kh),
            Text(
              Strings.accNumber,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterNumber)
                .paddingOnly(bottom: 16.kh),
            Text(
              Strings.transitNumber,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterNumber)
                .paddingOnly(bottom: 16.kh),
            Text(
              Strings.institutionNumber,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterNumber)
                .paddingOnly(bottom: 16.kh),
            const Expanded(child: SizedBox()),
            Obx(
              () => GreenPoolButton(
                onPressed: () {},
                label: Strings.send,
                isActive: controller.buttonState.value,
              ).paddingSymmetric(vertical: 40.kh),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

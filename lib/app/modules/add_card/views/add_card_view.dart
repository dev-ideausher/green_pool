import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/add_card_controller.dart';

class AddCardView extends GetView<AddCardController> {
  const AddCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(Strings.payment),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.addNewcard,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 32.kh, bottom: 16.kh),
            Text(
              Strings.cardHolderName,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterName)
                .paddingOnly(bottom: 16.kh),
            Text(
              Strings.cardNumber,
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: Strings.enterCardNumber)
                .paddingOnly(bottom: 16.kh),
            Row(
              children: [
                SizedBox(
                  width: 55.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.expiryDate,
                        style: TextStyleUtil.k14Semibold(),
                      ).paddingOnly(bottom: 8.kh),
                      GreenPoolTextField(
                        hintText: Strings.mmYY,
                        isSuffixNeeded: false,
                        onTap: () {},
                      ).paddingOnly(top: 8.kh, bottom: 16.kh, right: 8.kw),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.cvv,
                        style: TextStyleUtil.k14Semibold(),
                      ).paddingOnly(bottom: 8.kh),
                      GreenPoolTextField(
                        hintText: '***',
                        isSuffixNeeded: false,
                        onTap: () {},
                      ).paddingOnly(top: 8.kh, bottom: 16.kh),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () {},
              label: Strings.proceed,
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

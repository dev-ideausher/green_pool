import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
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
        appBar: const GreenPoolAppBar(
          title: Text("Payment"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Card",
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 32.kh, bottom: 16.kh),
            Text(
              "Card Holder Name",
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: "Enter name")
                .paddingOnly(bottom: 16.kh),
            Text(
              "Card Number",
              style: TextStyleUtil.k14Semibold(),
            ).paddingOnly(bottom: 8.kh),
            GreenPoolTextField(hintText: "Enter card number")
                .paddingOnly(bottom: 16.kh),
            Row(
              children: [
                SizedBox(
                  width: 55.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expiry Date",
                        style: TextStyleUtil.k14Semibold(),
                      ).paddingOnly(bottom: 8.kh),
                      GreenPoolTextField(
                        hintText: 'MM/YY',
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
                        "CVV",
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
              label: "Proceed",
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

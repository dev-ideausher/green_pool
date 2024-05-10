import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GreenPoolAppBar(
        title: Text(Strings.helpAndSupport),
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.getYourAnsHere,
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(bottom: 8.kh),
           GreenPoolTextField(
            hintText: Strings.howCanWeHelpYou,
            suffix: const Icon(
              Icons.chevron_right,
              color: ColorUtil.kBlack01,
            ),
            prefix: const Icon(
              Icons.search,
              color: ColorUtil.kBlack02,
            ),
          ).paddingOnly(bottom: 32.kh),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.trips,
                style: TextStyleUtil.k18Bold(),
              ),
              Expanded(
                child: Container(
                  height: 1.kh,
                  color: ColorUtil.kNeutral2,
                ).paddingOnly(left: 8.kw),
              ),
            ],
          ).paddingOnly(bottom: 20.kh),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.payments,
                style: TextStyleUtil.k18Bold(),
              ),
              Expanded(
                child: Container(
                  height: 1.kh,
                  color: ColorUtil.kNeutral2,
                ).paddingOnly(left: 8.kw),
              ),
            ],
          ).paddingOnly(bottom: 20.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

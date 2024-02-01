import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/create_account_controller.dart';

class TermsView extends GetView<CreateAccountController> {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            ImageConstant.svgIconBack,
            height: 30.kh,
            width: 30.kw,
          ).paddingAll(8.kh),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms and Condition",
            style: TextStyleUtil.k32Heading700(),
          ).paddingOnly(bottom: 4.kh),
          Text(
            "Before you proceed you must read and agree to\nGreen Pool's Terms and Conditions.",
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
          ).paddingOnly(bottom: 32.kh),
          Text(
            "Lorem ipsum dolor sit amet consectetur. Lorem viverra rutrum amet pulvinar dictum aliquam vulputate amet lacus. Dui sit ut tortor egestas nibh nullam egestas. Sed bibendum habitasse eget id. Eu malesuada nulla ac vel sollicitudin proin ut. Lacus faucibus morbi placerat nisi curabitur id donec.\n\n\nNetus vitae nunc mauris fringilla. Nibh nisi pellentesque leo diam gravida. Semper massa laoreet tortor at amet lacus lacus turpis tellus. Arcu eu senectus a pellentesque quisque pretium. Sit nisi in tempor posuere urna aliquam. Pulvinar feugiat ac cursus aliquet convallis imperdiet eget natoque. Tellus leo elementum tristique ut mi venenatis dolor lorem. Morbi morbi vel leo donec erat at mi tristique. Ullamcorper nisi ut tellus nibh ornare velit vulputate ipsum id.\n\n\nArcu eu senectus a pellentesque quisque pretium. Sit nisi in tempor posuere urna aliquam. Pulvinar feugiat ac cursus aliquet convallis imperdiet eget natoque. Tellus leo elementum tristique ut mi venenatis dolor lorem. Morbi morbi vel leo donec erat at mi tristique. Ullamcorper nisi ut tellus nibh ornare velit vulputate ipsum id.",
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/modules/profile/controllers/profile_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/student_discounts_controller.dart';

class StudentDiscountsView extends GetView<StudentDiscountsController> {
  const StudentDiscountsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Student Discounts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Student receive a ',
                  style: TextStyleUtil.k16Bold(),
                ),
                TextSpan(
                  text: '“\$5”',
                  style: TextStyleUtil.k18Bold(
                      color: Get.find<ProfileController>().isSwitched.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01),
                ),
                TextSpan(
                  text: ' discount after\nverifying their email ids',
                  style: TextStyleUtil.k16Bold(),
                ),
              ],
            ),
          ).paddingOnly(top: 32.kh, bottom: 24.kh),
          Text(
            'School',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Search for school',
            prefix: Icon(
              Icons.search,
              color: Get.find<ProfileController>().isSwitched.value
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kBlack02,
            ),
            suffix: const Icon(
              Icons.chevron_right,
              color: ColorUtil.kBlack01,
            ),
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Student email Id',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          const GreenPoolTextField(hintText: 'Enter student email id'),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () {},
            label: 'Verify your email',
          ).paddingSymmetric(vertical: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

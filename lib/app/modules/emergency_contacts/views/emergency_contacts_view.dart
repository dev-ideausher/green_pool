import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/emergency_contacts_controller.dart';

class EmergencyContactsView extends GetView<EmergencyContactsController> {
  const EmergencyContactsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.emergencyContacts),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.addEmergencyContacts,
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(top: 32.kh, bottom: 24.kh),
          Text(
            Strings.contactNumberOne,
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            Strings.fullName,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: Strings.enterFullName,
            controller: controller.fullName1,
          ).paddingOnly(bottom: 16.kh),
          Text(
            Strings.phoneNumber,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: Strings.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            controller: controller.emergencyNumber1,
            onchanged: (value) {
              controller.setButtonState();
            },
          ).paddingOnly(bottom: 24.kh),
          const GreenPoolDivider().paddingOnly(bottom: 16.kh),
          Text(
            Strings.contactNumberTwo,
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            Strings.fullName,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: Strings.enterFullName,
            controller: controller.fullName2,
          ).paddingOnly(bottom: 16.kh),
          Text(
            Strings.phoneNumber,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: Strings.enterPhoneNumber,
            keyboardType: TextInputType.phone,
            controller: controller.emergencyNumber2,
            onchanged: (value) {
              controller.setButtonState();
            },
          ).paddingOnly(bottom: 24.kh),
          const GreenPoolDivider(),
          const Expanded(child: SizedBox()),
          Obx(
            () => GreenPoolButton(
              onPressed: () => controller.emergencyContactsAPI(),
              isActive: controller.buttonState.value,
              label: Strings.addContacts,
            ).paddingOnly(bottom: 40.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

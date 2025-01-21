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

import '../../../../generated/locales.g.dart';
import '../controllers/emergency_contacts_controller.dart';

class EmergencyContactsView extends GetView<EmergencyContactsController> {
  const EmergencyContactsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_emergencyContacts.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.app_addEmergencyContacts.tr,
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(top: 32.kh, bottom: 24.kh),
          Text(
            LocaleKeys.app_contactNumberOne.tr,
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            LocaleKeys.app_fullName.tr,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: LocaleKeys.app_enterFullName.tr,
            controller: controller.fullName1,
          ).paddingOnly(bottom: 16.kh),
          Text(
            LocaleKeys.app_phoneNumber.tr,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: LocaleKeys.app_enterPhoneNumber.tr,
            keyboardType: TextInputType.phone,
            controller: controller.emergencyNumber1,
            onchanged: (value) {
              controller.setButtonState();
            },
          ).paddingOnly(bottom: 24.kh),
          const GreenPoolDivider().paddingOnly(bottom: 16.kh),
          Text(
            LocaleKeys.app_contactNumberTwo.tr,
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            LocaleKeys.app_fullName.tr,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: LocaleKeys.app_enterFullName.tr,
            controller: controller.fullName2,
          ).paddingOnly(bottom: 16.kh),
          Text(
            LocaleKeys.app_phoneNumber.tr,
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: LocaleKeys.app_enterPhoneNumber.tr,
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
              label: LocaleKeys.app_addContacts.tr,
            ).paddingOnly(bottom: 40.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

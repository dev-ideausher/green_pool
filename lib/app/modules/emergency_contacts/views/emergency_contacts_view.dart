import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
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
      appBar: const GreenPoolAppBar(
        title: Text('Emergency Contacts'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Emergency Contacts",
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(top: 32.kh, bottom: 24.kh),
          Text(
            'Contact number 1',
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Full Name',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter full name',
            controller: controller.fullName1,
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Phone number',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter phone number',
            controller: controller.emergencyNumber1,
            // onchanged: (value) {
            //     controller.emergencyContacts1.phone = value;
            // },
          ).paddingOnly(bottom: 24.kh),
          const GreenPoolDivider(),
          Text(
            'Contact number 2',
            style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack02),
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Full Name',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter full name',
            controller: controller.fullName2,
          ).paddingOnly(bottom: 16.kh),
          Text(
            'Phone number',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh),
          GreenPoolTextField(
            hintText: 'Enter phone number',
            controller: controller.emergencyNumber2,
            // onchanged: (value) {
            //     controller.emergencyContacts1.phone = value;
            // },
          ).paddingOnly(bottom: 24.kh),
          const GreenPoolDivider(),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () => controller.emergencyContactsAPI(),
            // onPressed: () {},
            label: 'Add Contacts',
          ).paddingOnly(bottom: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

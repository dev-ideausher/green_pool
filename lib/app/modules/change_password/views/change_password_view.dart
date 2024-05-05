import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../services/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Change Password'),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Old Password',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh, top: 32.kh),
          Obx(
            () => GreenPoolTextField(
              hintText: 'Enter old password',
              obscureText: controller.isOldPassVisible.value,
              onPressedSuffix: controller.setOldVisible,
              suffix: controller.isOldPassVisible.value
                  ? Icon(
                      Icons.visibility_off,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    )
                  : Icon(
                      Icons.visibility,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    ),
            ),
          ),
          Text(
            'New Password',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh, top: 32.kh),
          Obx(
            () => GreenPoolTextField(
                hintText: 'Enter new password',
                obscureText: controller.isNewPassVisible.value,
                onPressedSuffix: controller.setNewVisible,
                suffix: controller.isNewPassVisible.value
                    ? Icon(
                        Icons.visibility_off,
                        size: 20.kh,
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      )
                    : Icon(
                        Icons.visibility,
                        size: 20.kh,
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      )),
          ),
          Text(
            'Confirm Password',
            style: TextStyleUtil.k14Semibold(),
          ).paddingOnly(bottom: 8.kh, top: 32.kh),
          Obx(
            () => GreenPoolTextField(
              hintText: 're-enter new password',
              obscureText: controller.isConfirmPassVisible.value,
              onPressedSuffix: controller.setConfirmVisible,
              suffix: controller.isConfirmPassVisible.value
                  ? Icon(
                      Icons.visibility_off,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    )
                  : Icon(
                      Icons.visibility,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    ),
            ),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () {},
            label: 'Save',
          ).paddingSymmetric(vertical: 40.kh),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

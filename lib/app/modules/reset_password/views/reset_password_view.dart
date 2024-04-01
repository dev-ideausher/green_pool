import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GreenPoolAppBar(
        appBarSize: 60.kh,
      ),
      body: Form(
        key: controller.passwordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Password",
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'Enter new password',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 80.kh),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                Text(
                  'New Password',
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                Obx(
                  () => GreenPoolTextField(
                    hintText: 'Enter here',
                    suffix: controller.isVisible.value
                        ? Icon(
                            Icons.visibility,
                            size: 20.kh,
                            color: ColorUtil.kSecondary01,
                          )
                        : Icon(
                            Icons.visibility_off_sharp,
                            size: 20.kh,
                            color: ColorUtil.kSecondary01,
                          ),
                    onPressedSuffix: () {
                      controller.setVisible();
                    },
                    obscureText: !controller.isVisible.value,
                    controller: controller.passwordControllerOne,
                    validator: (value) => controller.passwordValidator(value),
                    onchanged: (v) {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                  ).paddingOnly(bottom: 12.kh),
                ),
                //

                //
                Text(
                  'Re-enter New Password',
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                Obx(
                  () => GreenPoolTextField(
                    hintText: 'Enter here',
                    suffix: controller.isVisibleTwo.value
                        ? Icon(
                            Icons.visibility,
                            size: 20.kh,
                            color: ColorUtil.kSecondary01,
                          )
                        : Icon(
                            Icons.visibility_off_sharp,
                            size: 20.kh,
                            color: ColorUtil.kSecondary01,
                          ),
                    onPressedSuffix: () {
                      controller.setVisibleTwo();
                    },
                    obscureText: !controller.isVisibleTwo.value,
                    controller: controller.passwordControllerTwo,
                    validator: (value) =>
                        controller.confirmPasswordValidator(value),
                    onchanged: (v) {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofocus: true,
                  ).paddingOnly(bottom: 12.kh),
                ),
                //
              ],
            ),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () async {
                controller.checkPassword();
              },
              color: ColorUtil.kPrimary01,
              label: 'Continue',
            ).paddingSymmetric(vertical: 40.kh)
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

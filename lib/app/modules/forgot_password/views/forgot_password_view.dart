import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: GreenPoolAppBar(
        appBarSize: 60.kh,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verify Account",
            style: TextStyleUtil.k32Heading700(),
          ).paddingOnly(bottom: 4.kh),
          Text(
            'Enter your registered email address',
            style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
          ).paddingOnly(bottom: 80.kh),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "We will send a verification link to your\nregistered email address",
                style: TextStyleUtil.k16Regular(),
                textAlign: TextAlign.center,
              ).paddingOnly(bottom: 30.kh)),
              //
              Text(
                'Email Address',
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: 'Enter here',
                // controller: controller.phoneNumberController,
                // validator: (value) => controller.phoneNumberValidator(value),
                onchanged: (v) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
              ).paddingOnly(bottom: 12.kh),

              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn't get the link? ",
                        style: TextStyleUtil.k14Regular(
                            color: ColorUtil.kNeutral4),
                      ),
                      TextSpan(
                        text: 'Resend',
                        style: TextStyleUtil.k16Semibold(
                            fontSize: 16.kh, color: ColorUtil.kSecondary01),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () async {
              Get.toNamed(Routes.FORGOT_PASSWORD_OTP);
            },
            color: ColorUtil.kPrimary01,
            label: 'Proceed',
          ).paddingSymmetric(vertical: 40.kh)
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

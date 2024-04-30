import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/verify/controllers/verify_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:pinput/pinput.dart';

class VerifyView extends GetView<VerifyController> {
  const VerifyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  GreenPoolAppBar(appBarSize: 60.kh,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter OTP",
            style: TextStyleUtil.k32Heading700(),
          ).paddingOnly(bottom: 4.kh),
          Text(
            'Enter otp',
            style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
          ).paddingOnly(bottom: 80.kh),
          Center(
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Please enter the verification code sent to\n',
                          style: TextStyleUtil.k16Regular(
                              color: ColorUtil.kBlack04)),
                      TextSpan(
                          text: controller.phoneNumber,
                          style: TextStyleUtil.k16Regular()),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 40.kh),
                Pinput(
                  length: 6,
                  controller: controller.otpController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  autofocus: true,
                  closeKeyboardWhenCompleted: true,
                  onCompleted: (value) async {
                    await controller.verifyOTP();
                  },
                  preFilledWidget: Text(
                    '0',
                    style: TextStyleUtil.k18Regular(color: ColorUtil.kBlack04),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  disabledPinTheme: PinTheme(
                      height: 64.kh,
                      width: 64.kw,
                      decoration: BoxDecoration(
                          color: ColorUtil.kSecondary07,
                          borderRadius: BorderRadius.circular(8.kh))),
                  defaultPinTheme: PinTheme(
                      height: 64.kh,
                      width: 64.kw,
                      textStyle:
                          TextStyleUtil.k18Regular(color: ColorUtil.kNeutral6),
                      decoration: BoxDecoration(
                          color: ColorUtil.kSecondary07,
                          borderRadius: BorderRadius.circular(8.kh))),
                  focusedPinTheme: PinTheme(
                      height: 64.kh,
                      width: 64.kw,
                      decoration: BoxDecoration(
                          color: ColorUtil.kSecondary07,
                          borderRadius: BorderRadius.circular(8.kh),
                          border: Border.all(color: ColorUtil.kBlack01))),
                ).paddingOnly(bottom: 16.kh),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Didn't get the code? ",
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack04)),
                      TextSpan(
                          text: 'Resend',
                          style: TextStyleUtil.k16Semibold(
                              fontSize: 16.kh, color: ColorUtil.kSecondary01)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          GreenPoolButton(
            onPressed: () async {
              await controller.verifyOTP();
            },
            color: ColorUtil.kPrimary01,
            label: 'Verify',
          ).paddingSymmetric(vertical: 40.kh)
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

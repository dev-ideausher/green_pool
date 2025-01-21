import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/wallet_to_bank_acc_controller.dart';

class WalletToBankAccView extends GetView<WalletToBankAccController> {
  const WalletToBankAccView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_payout.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 24.kh),
            width: 100.w,
            height: 188.kh,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.kh),
                gradient: Get.find<HomeController>().isPinkModeOn.value
                    ? const LinearGradient(colors: [
                        ColorUtil.kSecondaryPinkMode,
                        ColorUtil.kPrimaryPinkMode
                      ])
                    : const LinearGradient(
                        colors: [ColorUtil.kPrimary04, ColorUtil.kPrimary01])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.app_carpoollCash.tr,
                  style: TextStyleUtil.k18Heading600(),
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 16.kh),
                Text(
                  "${LocaleKeys.app_dollar.tr} ${Get.find<WalletController>().walletBalance}",
                  style: TextStyleUtil.k32Heading700(
                      color: ColorUtil.kSecondary01),
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 20.kh),
              ],
            ),
          ).paddingOnly(top: 32.kh, bottom: 24.kh),
          Container(
            width: 100.w,
            padding: EdgeInsets.all(16.kh),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.kh),
                color: ColorUtil.kWhiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.app_sendMoneyToBankAccount.tr,
                  style: TextStyleUtil.k16Bold(),
                ).paddingOnly(bottom: 24.kh),
                Text(
                  LocaleKeys.app_amount.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: LocaleKeys.app_enterAmount.tr,
                  prefix: Text(
                    LocaleKeys.app_dollar.tr,
                    style: TextStyleUtil.k16Regular(
                      color: ColorUtil.kBlack03,
                    ),
                  ),
                  controller: controller.amountTextController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Only allow digits (0-9)
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[^\w\s]')), // Deny all special characters
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: (p0) => controller.fareValidator(p0 ?? '0'),
                  onchanged: (value) => controller.setButtonState(value ?? ""),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Obx(
            () => GreenPoolButton(
              onPressed: () {
                // Get.toNamed(Routes.ADD_BANK_DETAILS);
                controller.moveToWebToBankAcc();
              },
              label: LocaleKeys.app_proceed.tr,
              isActive: controller.buttonState.value,
            ).paddingSymmetric(vertical: 40.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

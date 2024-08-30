import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/wallet_add_money_controller.dart';

class WalletAddMoneyView extends GetView<WalletAddMoneyController> {
  const WalletAddMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.addMoneyToWallet),
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
                  Strings.carpoollCash,
                  style: TextStyleUtil.k18Heading600(),
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 16.kh),
                Obx(
                  () => Text(
                    "${Strings.dollar} ${Get.find<WalletController>().walletBalance}",
                    style: TextStyleUtil.k32Heading700(
                        color: ColorUtil.kSecondary01),
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 20.kh),
                ),
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
                  Strings.addMoneyToWallet,
                  style: TextStyleUtil.k16Bold(),
                ).paddingOnly(bottom: 24.kh),
                Text(
                  Strings.amount,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: Strings.enterAmount,
                  prefix: Text(
                    Strings.dollar,
                    style: TextStyleUtil.k16Regular(
                      color: ColorUtil.kBlack03,
                    ),
                  ),
                  controller: controller.amountTextController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: const TextInputType.numberWithOptions(),
                  onchanged: (value) {
                    controller.setButtonState(value ?? "");
                  },
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '*',
                        style:
                            TextStyleUtil.k14Regular(color: ColorUtil.kError3),
                      ),
                      TextSpan(
                        text: Strings.minimumAdditionAmnt,
                        style:
                            TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                      ),
                    ],
                  ),
                ).paddingOnly(top: 4.kh, left: 2.kw),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Obx(
            () => GreenPoolButton(
              onPressed: () => controller.addMoney(),
              label: Strings.proceed,
              isActive: controller.buttonState.value,
            ).paddingSymmetric(vertical: 40.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

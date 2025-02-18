import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pay_now_controller.dart';

class PayNowView extends GetView<PayNowController> {
  const PayNowView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getWallet();
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_payment.tr),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OriginToDestination(
                            origin: controller.origin ?? "",
                            stop1: controller.stop1 ?? "",
                            stop2: controller.stop2 ?? "",
                            destination: controller.destination ?? "",
                            needPickupText: false)
                        .paddingSymmetric(horizontal: 16.kw),
                    24.kheightBox,
                    Text(
                      LocaleKeys.app_promotions.tr,
                      style: TextStyleUtil.k16Bold(),
                    ).paddingOnly(bottom: 16.kh),
                    ListTile(
                      tileColor: ColorUtil.kWhiteColor,
                      title: Text(
                        LocaleKeys.app_seatsBooked.tr,
                        style: TextStyleUtil.k14Semibold(),
                      ),
                      leading: Icon(
                        Icons.person,
                        color: isPinkModeOn
                            ? ColorUtil.kPrimary2PinkMode
                            : ColorUtil.kPrimary01,
                        size: 24.kh,
                      ),
                      trailing: Text(
                        controller.seatsBooked ?? "0",
                        style: TextStyleUtil.k14Semibold(),
                      ),
                    ).paddingOnly(bottom: 4.kh),
                    Obx(
                      () => ListTile(
                        tileColor: ColorUtil.kWhiteColor,
                        // onTap: () {
                        // controller.promoCodeAPI();
                        // Get.to(() => const PromoCode());
                        // },
                        title: SizedBox(
                          width: 20.w,
                          child: GreenPoolTextField(
                            hintText: LocaleKeys.app_applyCode.tr,
                            controller: controller.code,
                            readOnly: controller.promoCodeApplied.value,
                            inputFormatters: [
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => TextEditingValue(
                                  text: newValue.text.toUpperCase(),
                                  selection: newValue.selection,
                                ),
                              ),
                              FilteringTextInputFormatter.deny(
                                RegExp(r'\s'),
                              ),
                              LengthLimitingTextInputFormatter(30),
                            ],
                          ),
                        ),
                        trailing: controller.promoCodeApplied.value
                            ? Icon(
                                Icons.check,
                                size: 24.kh,
                                color: isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kPrimary01,
                              )
                            : controller.checkingCode.value
                                ? SizedBox(
                                    height: 12.kh,
                                    width: 12.kh,
                                    child: const GpProgress())
                                : TextButton(
                                    onPressed: () {
                                      controller.verifyPromoCodeAPI(
                                          controller.code.value.text);
                                    },
                                    child: Text(
                                      LocaleKeys.app_apply.tr,
                                      style: TextStyleUtil.k14Bold(),
                                    )),
                        /*leading: Icon(
                          Icons.add,
                          color: Get.find<HomeController>().isPinkModeOn.value
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kPrimary01,
                          size: 24.kh,
                        ),*/
                      ).paddingOnly(bottom: 4.kh),
                    ),
                    /*Visibility(
                      visible: controller.discountAvailed.value,
                      child: ListTile(
                        tileColor: ColorUtil.kWhiteColor,
                        title: Text(
                          "'${controller.promoCodeTitle}' Applied",
                          style: TextStyleUtil.k14Bold(),
                        ),
                        leading: Icon(
                          Icons.discount,
                          color: Get.find<HomeController>().isPinkModeOn.value
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kPrimary01,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            controller.discountAvailed.value = false;
                            controller.totalAmount =
                                (double.parse(controller.price.toString()) +
                                    controller.platformFees);
                            controller.promoCodeId = "";
                          },
                          child: Text(
                            LocaleKeys.app_remove.tr,
                            style: TextStyleUtil.k12Bold(
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary03,
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    24.kheightBox,
                    ListTile(
                      tileColor: ColorUtil.kWhiteColor,
                      minTileHeight: 76.kh,
                      onTap: () {
                        controller.moveToWallet();
                      },
                      title: Text(
                        LocaleKeys.app_walletBalance.tr,
                        style: TextStyleUtil.k14Semibold(),
                      ),
                      leading: Container(
                        height: 44.kh,
                        width: 44.kw,
                        padding: EdgeInsets.all(10.kh),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.kh),
                            color: ColorUtil.kBlack07),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: isPinkModeOn
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kPrimary01,
                          size: 24.kh,
                        ),
                      ),
                      trailing: Text(
                        "\$${controller.walletBalance.value}",
                        style: TextStyleUtil.k16Bold(
                            color: ColorUtil.kSecondary01),
                      ),
                    ).paddingOnly(bottom: 16.kh),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.kw, vertical: 12.kh),
                      decoration: BoxDecoration(
                          color: ColorUtil.kWhiteColor,
                          borderRadius: BorderRadius.circular(8.kh)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.app_subtotal.tr,
                                style: TextStyleUtil.k14Regular(
                                    color: ColorUtil.kBlack03),
                              ),
                              Text("\$${controller.price.toStringAsFixed(2)}",
                                  style: TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03))
                            ],
                          ),
                          4.kheightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.app_platformFees.tr,
                                style: TextStyleUtil.k14Regular(
                                    color: ColorUtil.kBlack03),
                              ),
                              Text(
                                  "\$${controller.platformFees.toStringAsFixed(2)}",
                                  style: TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03))
                            ],
                          ),
                          Visibility(
                            visible: controller.discountAvailed.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.app_discount.tr,
                                  style: TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03),
                                ),
                                Text("-\$${controller.discountProvided}",
                                    style: TextStyleUtil.k14Regular(
                                        color: ColorUtil.kError2))
                              ],
                            ),
                          ).paddingOnly(top: 4.kh),
                          const GreenPoolDivider()
                              .paddingSymmetric(vertical: 8.kh),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.app_toPay.tr,
                                style: TextStyleUtil.k14Bold(
                                    color: ColorUtil.kBlack02),
                              ),
                              Text(
                                  !controller.discountAvailed.value
                                      ? "\$${(controller.price + controller.platformFees).toStringAsFixed(2)}"
                                      : "\$${(controller.totalAmount + controller.platformFees).toStringAsFixed(2)}",
                                  style: TextStyleUtil.k14Bold(
                                      color: ColorUtil.kBlack02)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.kheightBox,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.kw, vertical: 12.kh),
                      decoration: BoxDecoration(
                          color: ColorUtil.kWhiteColor,
                          borderRadius: BorderRadius.circular(8.kh)),
                      child: Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.isChecked.value,
                              activeColor: isPinkModeOn
                                  ? ColorUtil.kPrimary2PinkMode
                                  : ColorUtil.kSecondary01,
                              onChanged: (value) {
                                controller.toggleCheckbox();
                              },
                            ),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: LocaleKeys
                                        .app_iConsentToTheseGuidelines.tr,
                                    style: TextStyleUtil.k12Regular(),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys
                                        .app_driverCancellationPolicyf.tr,
                                    style: TextStyleUtil.k12Semibold(
                                        color: isPinkModeOn
                                            ? ColorUtil.kPrimary2PinkMode
                                            : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => controller.getDriverPolicy(),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys
                                        .app_riderCancellationPolicyf.tr,
                                    style: TextStyleUtil.k12Semibold(
                                        color: isPinkModeOn
                                            ? ColorUtil.kPrimary2PinkMode
                                            : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => controller.getRiderPolicy(),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.app_termsAndConditions.tr,
                                    style: TextStyleUtil.k12Semibold(
                                        color: isPinkModeOn
                                            ? ColorUtil.kPrimary2PinkMode
                                            : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.toNamed(Routes.TERMS_CONDITIONS),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.app_and.tr,
                                    style: TextStyleUtil.k12Regular(),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys.app_privacyPolicyf.tr,
                                    style: TextStyleUtil.k12Semibold(
                                        color: isPinkModeOn
                                            ? ColorUtil.kPrimary2PinkMode
                                            : ColorUtil.kSecondary03),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.toNamed(Routes.POLICY_PRIVACY),
                                  ),
                                  TextSpan(
                                    text: LocaleKeys
                                        .app_iAcknowledgeThatMyAccMayFaceSuspension
                                        .tr,
                                    style: TextStyleUtil.k12Regular(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.kheightBox,
                    GreenPoolButton(
                      onPressed: () {
                        controller.decideAPI();
                      },
                      label: LocaleKeys.app_payNow.tr,
                      isActive: controller.isChecked.value,
                    ).paddingOnly(bottom: 20.kh),
                  ],
                ).paddingOnly(top: 24.kh, left: 16.kw, right: 16.kw),
              ),
      ),
    );
  }
}

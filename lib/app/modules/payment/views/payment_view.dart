import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/payment/controllers/payment_controller.dart';
import 'package:green_pool/app/modules/payment/views/promo_code.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getWallet();
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.payment),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 53.kh,
                  //   padding: EdgeInsets.all(16.kh),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.kh),
                  //     color: ColorUtil.kGreyColor,
                  //   ),
                  // ).paddingOnly(left: 16.kw, right: 16.kw, bottom: 8.kh),
                  // Container(
                  //   height: 53.kh,
                  //   padding: EdgeInsets.all(16.kh),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.kh),
                  //     color: ColorUtil.kGreyColor,
                  //   ),
                  // ).paddingSymmetric(horizontal: 16.kw),
                  OriginToDestination(
                          origin: controller.origin ?? "",
                          stop1: controller.stop1 ?? "",
                          stop2: controller.stop2 ?? "",
                          destination: controller.destination ?? "",
                          needPickupText: false)
                      .paddingSymmetric(horizontal: 16.kw),
                  24.kheightBox,
                  Text(
                    Strings.promotions,
                    style: TextStyleUtil.k16Bold(),
                  ).paddingOnly(bottom: 16.kh),
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    title: Text(
                      Strings.seatsBooked,
                      style: TextStyleUtil.k14Semibold(),
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary2PinkMode
                          : ColorUtil.kPrimary01,
                      size: 24.kh,
                    ),
                    trailing: Text(
                      controller.seatsBooked ?? "0",
                      style: TextStyleUtil.k14Semibold(),
                    ),
                  ).paddingOnly(bottom: 4.kh),
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    onTap: () {
                      controller.promoCodeAPI();
                      Get.to(() => const PromoCode());
                    },
                    title: Text(
                      Strings.addPromoCode,
                      style: TextStyleUtil.k14Semibold(),
                    ),
                    leading: Icon(
                      Icons.add,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary2PinkMode
                          : ColorUtil.kPrimary01,
                      size: 24.kh,
                    ),
                  ).paddingOnly(bottom: 4.kh),
                  Visibility(
                    visible: controller.discountAvailed.value,
                    child: ListTile(
                      tileColor: ColorUtil.kWhiteColor,
                      title: Text(
                        "'${controller.promoCodeTitle}' applied" ?? "",
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
                              double.parse(controller.price.toString());
                          controller.promoCodeId = "";
                        },
                        child: Text(
                          "Remove",
                          style: TextStyleUtil.k12Bold(
                            color: Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary03,
                          ),
                        ),
                      ),
                    ),
                  ),
                  24.kheightBox,
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    minTileHeight: 76.kh,
                    onTap: () {
                      controller.moveToWallet();
                    },
                    title: Text(
                      Strings.walletBalance,
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
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary2PinkMode
                            : ColorUtil.kPrimary01,
                        size: 24.kh,
                      ),
                    ),
                    trailing: Text(
                      "\$${controller.walletBalance.value}",
                      style:
                          TextStyleUtil.k16Bold(color: ColorUtil.kSecondary01),
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
                              Strings.subtotal,
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                            Text("\$${controller.price}",
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
                                Strings.discount,
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
                              Strings.toPay,
                              style: TextStyleUtil.k14Bold(
                                  color: ColorUtil.kBlack02),
                            ),
                            Text("\$${controller.totalAmount}",
                                style: TextStyleUtil.k14Bold(
                                    color: ColorUtil.kBlack02))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  GreenPoolButton(
                    onPressed: () {
                      controller.decideAPI();
                    },
                    label: Strings.payNow,
                    // isActive: controller.buttonState.value,
                  ).paddingSymmetric(vertical: 40.kh),
                ],
              ).paddingOnly(top: 24.kh, left: 16.kw, right: 16.kw),
      ),
    );
  }
}

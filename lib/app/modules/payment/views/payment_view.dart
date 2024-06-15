import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/modules/payment/controllers/payment_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text("Payment"),
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
                  Obx(
                    () => OriginToDestination(
                            origin: controller.fromDriverDetails.value
                                ? controller.rideData['ridesDetails']['origin']
                                        ['name']
                                    .toString()
                                : controller.fromConfirmRequestSection.value
                                    ? "${controller.riderConfirmRequestModelData?.driverRideDetails?.origin!.name.toString()}"
                                    : controller
                                        .riderSendRequestModelData.origin!.name
                                        .toString(),
                            destination: controller.fromDriverDetails.value
                                ? controller.rideData['ridesDetails']
                                        ['destination']['name']
                                    .toString()
                                : controller.fromConfirmRequestSection.value
                                    ? "${controller.riderConfirmRequestModelData?.driverRideDetails?.destination?.name.toString()}"
                                    : controller.riderSendRequestModelData
                                        .destination!.name
                                        .toString(),
                            needPickupText: false)
                        .paddingSymmetric(horizontal: 16.kw),
                  ),
                  24.kheightBox,
                  Text(
                    "Promotions",
                    style: TextStyleUtil.k16Bold(),
                  ).paddingOnly(bottom: 16.kh),
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    onTap: () {},
                    title: Text(
                      "Promotions available",
                      style: TextStyleUtil.k14Semibold(),
                    ),
                    leading: Icon(
                      Icons.discount,
                      color: ColorUtil.kPrimary01,
                    ),
                    trailing: Text(
                      "4",
                      style: TextStyleUtil.k14Bold(),
                    ),
                  ).paddingOnly(bottom: 4.kh),
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    onTap: () {},
                    title: Text(
                      "Add promo code",
                      style: TextStyleUtil.k14Semibold(),
                    ),
                    leading: Icon(
                      Icons.add,
                      color: ColorUtil.kPrimary01,
                      size: 24.kh,
                    ),
                  ),
                  24.kheightBox,
                  ListTile(
                    tileColor: ColorUtil.kWhiteColor,
                    minTileHeight: 76.kh,
                    onTap: () {
                      Get.toNamed(Routes.WALLET);
                    },
                    title: Text(
                      "Wallet  Balance",
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
                        color: ColorUtil.kPrimary01,
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
                              "Subtotal",
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                            Obx(() => controller.fromDriverDetails.value
                                ? Text(
                                    "\$${controller.rideData['ridesDetails']['price'].toString()}",
                                    style: TextStyleUtil.k14Regular(
                                        color: ColorUtil.kBlack03),
                                  )
                                : controller.fromConfirmRequestSection.value
                                    ? Text("\$${controller.price}",
                                        style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03))
                                    : Text(
                                        "\$${controller.riderSendRequestModelData.price.toString()}",
                                        style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03)))
                          ],
                        ),
                        const GreenPoolDivider()
                            .paddingSymmetric(vertical: 8.kh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To Pay",
                              style: TextStyleUtil.k14Bold(
                                  color: ColorUtil.kBlack02),
                            ),
                            Obx(() => controller.fromDriverDetails.value
                                ? Text(
                                    "\$${controller.rideData['ridesDetails']['price'].toString()}",
                                    style: TextStyleUtil.k14Bold(
                                        color: ColorUtil.kBlack02),
                                  )
                                : controller.fromConfirmRequestSection.value
                                    ? Text("\$${controller.price}",
                                        style: TextStyleUtil.k14Bold(
                                            color: ColorUtil.kBlack02))
                                    : Text(
                                        "\$${controller.riderSendRequestModelData.price.toString()}",
                                        style: TextStyleUtil.k14Bold(
                                            color: ColorUtil.kBlack02)))
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
                    label: "Pay now",
                  ).paddingSymmetric(vertical: 40.kh),
                ],
              ).paddingOnly(top: 24.kh, left: 16.kw, right: 16.kw),
      ),
    );
  }
}

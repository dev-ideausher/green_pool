import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/modules/post_ride_step_three/views/price_tile.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/richtext_heading.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/post_ride_step_three_controller.dart';

class PostRideStepThreeView extends GetView<PostRideStepThreeController> {
  const PostRideStepThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.postARide),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichTextHeading(
                          text: Strings.pricing,
                          style: TextStyleUtil.k18Bold(),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.kh,
                            color: ColorUtil.kNeutral2,
                          ).paddingOnly(left: 8.kw),
                        ),
                      ],
                    ).paddingOnly(top: 8.kh, bottom: 4.kh),
                    Text(
                      Strings.specifyAReasonableCost,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ).paddingOnly(bottom: 24.kh),
                    Text(
                      Strings.pricePerSeat,
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack01),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      Strings.thisPricingStrategy,
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
                    ),
                    Text(
                      '(Enter cost between ${controller.minFarePrice!.toStringAsFixed(0)} and ${controller.maxFarePrice!.toStringAsFixed(0)})',
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
                    ).paddingOnly(bottom: 8.kh),
                    //price from origin to destination
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 40.w,
                            height: 10.h,
                            child: GreenPoolTextField(
                              hintText: '',
                              isSuffixNeeded: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[0-9]')), // Only allow digits (0-9)
                                FilteringTextInputFormatter.deny(RegExp(
                                    r'[^\w\s]')), // Deny all special characters
                              ],
                              onchanged: (val) {
                                controller.setActiveStatePricing();
                                controller.postRideModel.value.ridesDetails
                                    ?.origin?.originDestinationFair = val;
                              },
                              validator: (v) => controller.fareValidator(v),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: true,
                              controller: controller.totalPrice,
                              prefix: Text(
                                '\$',
                                style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03,
                                ),
                              ),
                            )).paddingOnly(right: 8.kw),
                        Flexible(
                          child: SizedBox(
                            height: 10.h,
                            child: Text(
                              "${controller.postRideModel.value.ridesDetails?.origin?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.destination?.name.toString().split(",").first}",
                              style: TextStyleUtil.k14Semibold(),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: controller.postRideModel.value.ridesDetails!
                                  .stops?[0]?.name?.isEmpty ??
                              false
                          ? () {}
                          : () {
                              controller.viewPrice.value =
                                  !controller.viewPrice.value;
                            },
                      child: Obx(
                        () => controller.viewPrice.value
                            ? Text(
                                Strings.seeLess,
                                style: TextStyleUtil.k14Semibold(
                                    color: ColorUtil.kSecondary01,
                                    textDecoration: TextDecoration.underline),
                              ).paddingOnly(bottom: 12.kh)
                            : Text(
                                Strings.viewPriceOfEachStop,
                                style: TextStyleUtil.k14Semibold(
                                    color: ColorUtil.kSecondary01,
                                    textDecoration: TextDecoration.underline),
                              ).paddingOnly(bottom: 12.kh),
                      ),
                    ),

                    Obx(() => controller.viewPrice.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GreenPoolDivider(
                                color: ColorUtil.kNeutral8,
                              ).paddingOnly(bottom: 12.kh),
                              //From origin to stop 1
                              controller.postRideModel.value.ridesDetails!
                                      .stops![0]!.name!.isNotEmpty
                                  ? PriceTile(
                                      onchanged: (val) {
                                        /*   controller.setActiveStatePricing();
                                        controller
                                            .postRideModel
                                            .value
                                            .ridesDetails
                                            ?.stops?[0]
                                            ?.originToStopFair = val;*/
                                      },
                                      validator: (v) =>
                                          controller.fareValidator(v),
                                      trallingText:
                                          "${controller.postRideModel.value.ridesDetails?.origin?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.stops?[0]?.name.toString().split(",").first}",
                                      txtController:
                                          controller.originToStop1Price,
                                    )
                                  : const SizedBox(),
                              //From origin to stop 2
                              controller.postRideModel.value.ridesDetails!
                                      .stops![1]!.name!.isNotEmpty
                                  ? PriceTile(
                                      onchanged: (val) {
                                        /*  controller.setActiveStatePricing();
                                        controller.postRideModel.value.ridesDetails?.stops?[1]?.originToStopFair = val;*/
                                      },
                                      validator: (v) =>
                                          controller.fareValidator(v),
                                      trallingText:
                                          "${controller.postRideModel.value.ridesDetails?.origin?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.stops?[1]?.name.toString().split(",").first}",
                                      txtController:
                                          controller.originToStop2Price,
                                    )
                                  : const SizedBox(),
                              //From stop 1 to stop 2
                              (controller.postRideModel.value.ridesDetails!
                                          .stops![0]!.name!.isNotEmpty &&
                                      controller
                                          .postRideModel
                                          .value
                                          .ridesDetails!
                                          .stops![1]!
                                          .name!
                                          .isNotEmpty)
                                  ? PriceTile(
                                      onchanged: (val) {
                                        /*      controller.setActiveStatePricing();
                                        controller.postRideModel.value.ridesDetails?.stops?[0]?.stopToStopFair = val;*/
                                      },
                                      validator: (v) =>
                                          controller.fareValidator(v),
                                      txtController:
                                          controller.stop1ToStop2Price,
                                      trallingText:
                                          "${controller.postRideModel.value.ridesDetails?.stops?[0]?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.stops?[1]?.name.toString().split(",").first}",
                                    )
                                  : const SizedBox(),
                              //From stop 1 to destination
                              controller.postRideModel.value.ridesDetails!
                                      .stops![0]!.name!.isNotEmpty
                                  ? PriceTile(
                                      onchanged: (val) {
                                        /* controller.setActiveStatePricing();
                                        controller.postRideModel.value.ridesDetails?.stops?[0]?.stopTodestinationFair = int.parse(val ?? "0");*/
                                      },
                                      trallingText:
                                          "${controller.postRideModel.value.ridesDetails?.stops?[0]?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.destination?.name.toString().split(",").first}",
                                      txtController:
                                          controller.stop1ToDestinationPrice,
                                      validator: (v) =>
                                          controller.fareValidator(v),
                                    )
                                  : const SizedBox(),
                              //From stop 2 to destination
                              controller.postRideModel.value.ridesDetails!
                                      .stops![1]!.name!.isNotEmpty
                                  ? PriceTile(
                                      onchanged: (val) {
                                        /*      controller.setActiveStatePricing();
                                        controller.postRideModel.value.ridesDetails?.stops?[1]?.stopTodestinationFair = int.parse(val ?? "0");*/
                                      },
                                      validator: (v) =>
                                          controller.fareValidator(v),
                                      txtController:
                                          controller.stop2toDestinationPrice,
                                      trallingText:
                                          "${controller.postRideModel.value.ridesDetails?.stops?[1]?.name.toString().split(",").first} to ${controller.postRideModel.value.ridesDetails?.destination?.name.toString().split(",").first}",
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Strings.description,
                          style: TextStyleUtil.k18Bold(),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.kh,
                            color: ColorUtil.kNeutral2,
                          ).paddingOnly(left: 8.kw),
                        ),
                      ],
                    ).paddingOnly(top: 12.kh, bottom: 4.kh),
                    Text(
                      Strings.includeKeyTripDetails,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ).paddingOnly(bottom: 24.kh),
                    GreenPoolTextField(
                      hintText: Strings.enterTextHere,
                      controller: controller.descriptionTextController,
                      textCapitalization: TextCapitalization.sentences,
                      onchanged: (value) {
                        controller.postRideModel.value.ridesDetails
                            ?.description = value;
                      },
                      maxLines: 8,
                    ).paddingOnly(bottom: 30.kh),
                    Obx(
                      () => GreenPoolButton(
                        onPressed: () => controller.moveToGuidelines(),
                        isActive: controller.isActivePricingButton.value,
                        label: Strings.next,
                      ).paddingOnly(bottom: 40.kh),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              ),
      ),
    );
  }
}

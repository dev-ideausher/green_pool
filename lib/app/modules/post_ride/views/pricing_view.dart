import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/richtext_heading.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/post_ride_controller.dart';

class PricingView extends GetView<PostRideController> {
  const PricingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Post a Ride'),
      ),
      body: Obx(
        () => controller.isPriceLoading.value
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
                          text: 'Pricing',
                          style: TextStyleUtil.k18Bold(),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.kh,
                            color: ColorUtil.kNeutral2,
                          ).paddingOnly(left: 8.kw),
                        ),
                      ],
                    ).paddingOnly(top: 32.kh, bottom: 4.kh),
                    Text(
                      'Specify a reasonable cost per seat covering gas and additional expenses.',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ).paddingOnly(bottom: 24.kh),
                    Text(
                      'Price per seat (Recommended)',
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack01),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      'This pricing strategy ensures a competitive trip, maximizing your opportunities for passenger bookings.',
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
                      children: [
                        SizedBox(
                            width: 35.w,
                            height: 10.h,
                            child: GreenPoolTextField(
                              hintText: '',
                              isSuffixNeeded: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              onchanged: (val) =>
                                  controller.setActiveStatePricing(),
                              validator: (v) => controller.fareValidator(v),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: true,
                              controller: controller.priceTextController,
                              prefix: Text(
                                '\$',
                                style: TextStyleUtil.k16Regular(
                                  color: ColorUtil.kBlack03,
                                ),
                              ),
                            )),
                        Text(
                          "Origin to Destination",
                          style: TextStyleUtil.k14Semibold(),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.viewPrice.value =
                            !controller.viewPrice.value;
                      },
                      child: Obx(
                        () => controller.viewPrice.value
                            ? Text(
                                "See less",
                                style: TextStyleUtil.k14Semibold(
                                    color: ColorUtil.kSecondary01,
                                    textDecoration: TextDecoration.underline),
                              ).paddingOnly(bottom: 12.kh)
                            : Text(
                                "View price of each stop",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 35.w,
                                      height: 10.h,
                                      child: GreenPoolTextField(
                                        hintText: '',
                                        isSuffixNeeded: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        onchanged: (val) =>
                                            controller.setActiveStatePricing(),
                                        validator: (v) =>
                                            controller.fareValidator(v),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            controller.price2TextController,
                                        prefix: Text(
                                          '\$',
                                          style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03,
                                          ),
                                        ),
                                      )),
                                  Text(
                                    "Origin to Stop 1",
                                    style: TextStyleUtil.k14Semibold(),
                                  ),
                                ],
                              ),
                              //From origin to stop 2
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 35.w,
                                      height: 10.h,
                                      child: GreenPoolTextField(
                                        hintText: '',
                                        isSuffixNeeded: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        onchanged: (val) =>
                                            controller.setActiveStatePricing(),
                                        validator: (v) =>
                                            controller.fareValidator(v),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            controller.price3TextController,
                                        prefix: Text(
                                          '\$',
                                          style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03,
                                          ),
                                        ),
                                      )),
                                  Text(
                                    "Origin to stop 2",
                                    style: TextStyleUtil.k14Semibold(),
                                  ),
                                ],
                              ),
                              //From stop 1 to stop 2
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 35.w,
                                      height: 10.h,
                                      child: GreenPoolTextField(
                                        hintText: '',
                                        isSuffixNeeded: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        onchanged: (val) =>
                                            controller.setActiveStatePricing(),
                                        validator: (v) =>
                                            controller.fareValidator(v),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            controller.price4TextController,
                                        prefix: Text(
                                          '\$',
                                          style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03,
                                          ),
                                        ),
                                      )),
                                  Text(
                                    "Stop 1 to Stop 2",
                                    style: TextStyleUtil.k14Semibold(),
                                  ),
                                ],
                              ),
                              //From stop 1 to destination
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 35.w,
                                      height: 10.h,
                                      child: GreenPoolTextField(
                                        hintText: '',
                                        isSuffixNeeded: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        onchanged: (val) =>
                                            controller.setActiveStatePricing(),
                                        validator: (v) =>
                                            controller.fareValidator(v),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            controller.price5TextController,
                                        prefix: Text(
                                          '\$',
                                          style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03,
                                          ),
                                        ),
                                      )),
                                  Text(
                                    "Stop 1 to Destination",
                                    style: TextStyleUtil.k14Semibold(),
                                  ),
                                ],
                              ),
                              //From stop 2 to destination
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 35.w,
                                      height: 10.h,
                                      child: GreenPoolTextField(
                                        hintText: '',
                                        isSuffixNeeded: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(),
                                        onchanged: (val) =>
                                            controller.setActiveStatePricing(),
                                        validator: (v) =>
                                            controller.fareValidator(v),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller:
                                            controller.price6TextController,
                                        prefix: Text(
                                          '\$',
                                          style: TextStyleUtil.k14Regular(
                                            color: ColorUtil.kBlack03,
                                          ),
                                        ),
                                      )),
                                  Text(
                                    "Stop 2 to Destination",
                                    style: TextStyleUtil.k14Semibold(),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Description',
                          style: TextStyleUtil.k18Bold(),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.kh,
                            color: ColorUtil.kNeutral2,
                          ).paddingOnly(left: 8.kw),
                        ),
                      ],
                    ).paddingOnly(top: 32.kh, bottom: 4.kh),
                    Text(
                      'Include key trip details for informed bookings.',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ).paddingOnly(bottom: 24.kh),
                    GreenPoolTextField(
                      hintText: 'Enter text here',
                      controller: controller.descriptionTextController,
                      maxLines: 8,
                    ).paddingOnly(bottom: 50.kh),
                    Obx(
                      () => GreenPoolButton(
                        onPressed: () => Get.toNamed(Routes.GUIDELINES_VIEW),
                        isActive: controller.isActivePricingButton.value,
                        label: 'Next',
                      ).paddingOnly(bottom: 40.kh),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              ),
      ),
    );
  }
}

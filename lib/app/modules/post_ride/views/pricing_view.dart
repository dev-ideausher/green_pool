import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pricing',
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
              style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
            ).paddingOnly(bottom: 24.kh),
            Text(
              'Price per seat (Recommended)',
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack01),
            ).paddingOnly(bottom: 4.kh),
            Text(
              'This pricing strategy ensures a competitive trip, maximizing your opportunities for passenger bookings.',
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 8.kh),
            SizedBox(
                width: 50.w,
                height: 10.h,
                child: GreenPoolTextField(
                  hintText: '',
                  onchanged: (val) => controller.setActiveStatePricing(),
                  validator: (v) => controller.fareValidator(v),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                  controller: controller.priceTextController,
                  prefix: Text(
                    '\$',
                    style: TextStyleUtil.k14Regular(
                      color: ColorUtil.kBlack03,
                    ),
                  ),
                )),
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
              style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
            ).paddingOnly(bottom: 24.kh),
            const GreenPoolTextField(
              hintText: 'Enter text here',
              maxLines: 8,
            ).paddingOnly(bottom: 50.kh),
            Obx(
              () => GreenPoolButton(
                onPressed: () => Get.toNamed(Routes.GUIDELINES_VIEW),
                isActive: controller.isActivePricingButton.value,
                label: 'Next',
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

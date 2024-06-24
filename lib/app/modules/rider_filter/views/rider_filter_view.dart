import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';
import '../controllers/rider_filter_controller.dart';
import 'filter_list.dart';

class RiderFilterView extends GetView<RiderFilterController> {
  const RiderFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Filter'),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 24.kh, bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgIconTime,
              text: 'Early departure',
              onChanged: (value) {
                controller.earlyDeparture.value = value!;
              },
              value: controller.earlyDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities10,
              text: 'Lowest price',
              onChanged: (value) {
                controller.lowestPrice.value = value!;
              },
              value: controller.lowestPrice.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: 'Close to departure point',
              onChanged: (value) {
                controller.closeToDeparture.value = value!;
              },
              value: controller.closeToDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: 'Close to arrival',
              onChanged: (value) {
                controller.closeToArrival.value = value!;
              },
              value: controller.closeToArrival.value,
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Text(
              'Preferences',
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgAmenities1,
              text: 'Appreciates Conversations',
              onChanged: (value) {
                controller.appreciatesConvo.value = value!;
              },
              value: controller.appreciatesConvo.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities2,
              text: 'Enjoys music',
              onChanged: (value) {
                controller.enjoysMusic.value = value!;
              },
              value: controller.enjoysMusic.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities3,
              text: 'Smoke-free',
              onChanged: (value) {
                controller.smokeFree.value = value!;
              },
              value: controller.smokeFree.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities4,
              text: 'Pet-friendly',
              onChanged: (value) {
                controller.petFriendly.value = value!;
              },
              value: controller.petFriendly.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities5,
              text: 'Winter Tires',
              onChanged: (value) {
                controller.winterTires.value = value!;
              },
              value: controller.winterTires.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities6,
              text: 'Cooling or Heating',
              onChanged: (value) {
                controller.coolOrHeat.value = value!;
              },
              value: controller.coolOrHeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities7,
              text: 'Baby Seat',
              onChanged: (value) {
                controller.babySeat.value = value!;
              },
              value: controller.babySeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities8,
              text: 'Heated Seats',
              onChanged: (value) {
                controller.heatedSeats.value = value!;
              },
              value: controller.heatedSeats.value,
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GreenPoolButton(
                  onPressed: () {
                    controller.filterRideAPI();
                  },
                  label: 'Filter',
                  width: 156.kw,
                  height: 56.kh,
                ),
                GreenPoolButton(
                  onPressed: () {
                    controller.clearAll();
                  },
                  label: 'Clear All',
                  isBorder: true,
                  borderColor: ColorUtil.kSecondary01,
                  width: 156.kw,
                  height: 56.kh,
                ),
              ],
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

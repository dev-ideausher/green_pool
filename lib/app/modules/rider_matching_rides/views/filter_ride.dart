import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../rider_matching_rides/views/filter_list.dart';
import '../controllers/matching_rides_controller.dart';

class FilterRide extends GetView<MatchingRidesController> {
  const FilterRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GreenPoolAppBar(
        title: Text(Strings.filter),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.sortBy,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 24.kh, bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgIconTime,
              text: Strings.earlyDeparture,
              onChanged: (value) {
                controller.earlyDeparture.value = value!;
              },
              value: controller.earlyDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities10,
              text: Strings.lowestPrice,
              onChanged: (value) {
                controller.lowestPrice.value = value!;
              },
              value: controller.lowestPrice.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: Strings.closeToDeparture,
              onChanged: (value) {
                controller.closeToDeparture.value = value!;
              },
              value: controller.closeToDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: Strings.closeToArrival,
              onChanged: (value) {
                controller.closeToArrival.value = value!;
              },
              value: controller.closeToArrival.value,
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Text(
              Strings.preferences,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgAmenities1,
              text: Strings.appreciatesConversation,
              onChanged: (value) {
                controller.appreciatesConvo.value = value!;
              },
              value: controller.appreciatesConvo.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities2,
              text: Strings.enjoysMusic,
              onChanged: (value) {
                controller.enjoysMusic.value = value!;
              },
              value: controller.enjoysMusic.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities3,
              text: Strings.smokeFree,
              onChanged: (value) {
                controller.smokeFree.value = value!;
              },
              value: controller.smokeFree.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities4,
              text: Strings.petFriendly,
              onChanged: (value) {
                controller.petFriendly.value = value!;
              },
              value: controller.petFriendly.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities5,
              text: Strings.winterTires,
              onChanged: (value) {
                controller.winterTires.value = value!;
              },
              value: controller.winterTires.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities6,
              text: Strings.coolingOrHeating,
              onChanged: (value) {
                controller.coolOrHeat.value = value!;
              },
              value: controller.coolOrHeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities7,
              text: Strings.babySeat,
              onChanged: (value) {
                controller.babySeat.value = value!;
              },
              value: controller.babySeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities8,
              text: Strings.heatedSeats,
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
                  label: Strings.filter,
                  width: 156.kw,
                  height: 56.kh,
                ),
                GreenPoolButton(
                  onPressed: () {
                    controller.clearAll();
                  },
                  label: Strings.clearAll,
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
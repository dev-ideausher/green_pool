import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../../home/controllers/home_controller.dart';
import '../../rider_matching_rides/views/filter_list.dart';
import '../controllers/matching_rides_controller.dart';

class FilterRide extends GetView<MatchingRidesController> {
  const FilterRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_filter.tr),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.app_sortBy.tr,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 24.kh, bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgIconTime,
              text: LocaleKeys.app_earlyDeparture.tr,
              onChanged: (value) {
                controller.earlyDeparture.value = value!;
              },
              value: controller.earlyDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities10,
              text: LocaleKeys.app_lowestPrice.tr,
              onChanged: (value) {
                controller.lowestPrice.value = value!;
              },
              value: controller.lowestPrice.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: LocaleKeys.app_closeToDeparture.tr,
              onChanged: (value) {
                controller.closeToDeparture.value = value!;
              },
              value: controller.closeToDeparture.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities9,
              text: LocaleKeys.app_closeToArrival.tr,
              onChanged: (value) {
                controller.closeToArrival.value = value!;
              },
              value: controller.closeToArrival.value,
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Text(
              LocaleKeys.app_preferences.tr,
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(bottom: 16.kh),
            FilterList(
              image: ImageConstant.svgAmenities1,
              text: LocaleKeys.app_appreciatesConversation.tr,
              onChanged: (value) {
                controller.appreciatesConvo.value = value!;
              },
              value: controller.appreciatesConvo.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities2,
              text: LocaleKeys.app_enjoysMusic.tr,
              onChanged: (value) {
                controller.enjoysMusic.value = value!;
              },
              value: controller.enjoysMusic.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities3,
              text: LocaleKeys.app_smokeFree.tr,
              onChanged: (value) {
                controller.smokeFree.value = value!;
              },
              value: controller.smokeFree.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities4,
              text: LocaleKeys.app_petFriendly.tr,
              onChanged: (value) {
                controller.petFriendly.value = value!;
              },
              value: controller.petFriendly.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities5,
              text: LocaleKeys.app_winterTires.tr,
              onChanged: (value) {
                controller.winterTires.value = value!;
              },
              value: controller.winterTires.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities6,
              text: LocaleKeys.app_coolingOrHeating.tr,
              onChanged: (value) {
                controller.coolOrHeat.value = value!;
              },
              value: controller.coolOrHeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities7,
              text: LocaleKeys.app_babySeat.tr,
              onChanged: (value) {
                controller.babySeat.value = value!;
              },
              value: controller.babySeat.value,
            ),
            FilterList(
              image: ImageConstant.svgAmenities8,
              text: LocaleKeys.app_heatedSeats.tr,
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
                  label: LocaleKeys.app_filter.tr,
                  width: 156.kw,
                  height: 56.kh,
                ),
                GreenPoolButton(
                  onPressed: () {
                    controller.clearAll();
                  },
                  label: LocaleKeys.app_clearAll.tr,
                  isBorder: true,
                  width: 156.kw,
                  height: 56.kh,
                  borderColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  labelColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ],
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

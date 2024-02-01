import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/routes/app_pages.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort by',
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(top: 24.kh, bottom: 16.kh),
          FilterList(
            index: 0,
            image: ImageConstant.svgIconTime,
            text: 'Early departure',
          ),
          FilterList(
            index: 1,
            image: ImageConstant.svgAmenities10,
            text: 'Lowest price',
          ),
          FilterList(
            index: 2,
            image: ImageConstant.svgAmenities9,
            text: 'Close to departure point',
          ),
          FilterList(
            index: 3,
            image: ImageConstant.svgAmenities9,
            text: 'Close to arrival',
          ),
          const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
          Text(
            'Preferences',
            style: TextStyleUtil.k16Bold(),
          ).paddingOnly(bottom: 16.kh),
          FilterList(
              index: 4,
              image: ImageConstant.svgAmenities1,
              text: 'Appreciates Conversations'),
          FilterList(
              index: 5,
              image: ImageConstant.svgAmenities2,
              text: 'Enjoys music'),
          FilterList(
              index: 6, image: ImageConstant.svgAmenities3, text: 'Smoke-free'),
          FilterList(
              index: 7,
              image: ImageConstant.svgAmenities4,
              text: 'Pet-friendly'),
          FilterList(
              index: 8,
              image: ImageConstant.svgAmenities5,
              text: 'Winter Tired'),
          FilterList(
              index: 9,
              image: ImageConstant.svgAmenities6,
              text: 'Cooling or Heating'),
          FilterList(
              index: 10, image: ImageConstant.svgAmenities7, text: 'Baby Seat'),
          FilterList(
              index: 11,
              image: ImageConstant.svgAmenities8,
              text: 'Heated Seats'),
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GreenPoolButton(
                onPressed: () => Get.offNamed(Routes.MATCHING_RIDES),
                
                label: 'Filter',
                width: 156.kw,
                height: 56.kh,
              ),
              GreenPoolButton(
                onPressed: () => Get.offNamed(Routes.MATCHING_RIDES),
                
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
    );
  }
}

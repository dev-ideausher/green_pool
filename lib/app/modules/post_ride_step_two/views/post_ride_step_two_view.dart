import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/post_ride_step_two/views/amenities_list.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_appbar.dart';
import '../../../components/richtext_heading.dart';
import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../post_ride/views/green_pool_chip.dart';
import '../controllers/post_ride_step_two_controller.dart';
import 'one_time_trip_view.dart';
import 'recurring_trip_view.dart';

class PostRideStepTwoView extends GetView<PostRideStepTwoController> {
  const PostRideStepTwoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Post a Ride'),
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Carpool Schedule',
                    style: TextStyleUtil.k18Bold(),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.kh,
                      color: ColorUtil.kNeutral2,
                    ).paddingOnly(left: 8.kw),
                  ),
                ],
              ).paddingOnly(top: 32.kh),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.kh),
                  border: Border.all(color: ColorUtil.kNeutral1),
                  color: ColorUtil.kWhiteColor,
                ),
                child: TabBar(
                    onTap: (index) {
                      controller.tabIndex.value = index;
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.kh),
                        color: controller.isPinkMode.value
                            ? ColorUtil.kPrimaryPinkMode
                            : ColorUtil.kSecondary01),
                    unselectedLabelColor: ColorUtil.kSecondary01,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    overlayColor: MaterialStatePropertyAll(
                        ColorUtil.kSecondary01.withOpacity(0.05)),
                    labelColor: controller.isPinkMode.value
                        ? ColorUtil.kBlack01
                        : ColorUtil.kWhiteColor,
                    splashBorderRadius: BorderRadius.circular(80.kh),
                    unselectedLabelStyle: TextStyleUtil.k14Semibold(
                        color: ColorUtil.kSecondary01),
                    labelStyle: TextStyleUtil.k14Semibold(
                        color: controller.isPinkMode.value
                            ? ColorUtil.kBlack01
                            : ColorUtil.kSecondary01),
                    tabs: const [
                      Tab(
                        child: Text(
                          'One-Time Trip',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Recurring Trip',
                        ),
                      ),
                    ]),
              ).paddingOnly(top: 24.kh),
              Obx(() => controller.tabIndex.value == 0
                  ? const OneTimeTripView()
                  : const RecurringTripView()),

              //PREFERENCES
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Preferences',
                    style: TextStyleUtil.k18Bold(),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.kh,
                      color: ColorUtil.kNeutral2,
                    ).paddingOnly(left: 8.kw),
                  ),
                ],
              ).paddingSymmetric(vertical: 32.kh),
              RichTextHeading(
                text: 'Number of Seats Available',
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ).paddingOnly(bottom: 4.kh),
              Text(
                "Quality rides: Only 2 in the back for glowing\nreviews!",
                style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
              ).paddingOnly(bottom: 16.kh),
              Row(
                children: [
                  GestureDetector(
                      onTap: () => controller.decrement(),
                      child: SvgPicture.asset(
                        ImageConstant.svgIconMinus,
                        colorFilter: ColorFilter.mode(
                            controller.isPinkMode.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.kh),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorUtil.kBlack06, width: 2.kh),
                        borderRadius: BorderRadius.circular(40.kh),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageConstant.svgNavProfileFilled,
                            colorFilter: ColorFilter.mode(
                                controller.isPinkMode.value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ).paddingOnly(right: 4.kw),
                          Obx(
                            () => Text(
                              controller.count.value.toString(),
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ),
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 4.kw),
                  ),
                  GestureDetector(
                      onTap: () => controller.increment(),
                      child: SvgPicture.asset(
                        ImageConstant.svgIconPlus,
                        colorFilter: ColorFilter.mode(
                            controller.isPinkMode.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      )),
                ],
              ).paddingOnly(bottom: 24.kh),
              RichTextHeading(
                text: 'Luggage Allowance',
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Luggage Weight : ${" ${controller.luggageWeight.value}"}',
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
                    ).paddingOnly(top: 4.kh, bottom: 16.kh),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreenPoolChip(
                        controller: controller,
                        radius: 40.kh,
                        labelText: 'No',
                        selected: controller.selectedCHIP.value == 'No'
                            ? true
                            : false,
                        onPressed: () {
                          controller.selectedCHIP.value = 'No';
                          controller.luggageWeight.value = 'No';
                        }),
                    GreenPoolChip(
                        controller: controller,
                        radius: 40.kh,
                        labelText: 'S',
                        selected:
                            controller.selectedCHIP.value == 'S' ? true : false,
                        onPressed: () {
                          controller.selectedCHIP.value = 'S';
                          controller.luggageWeight.value = '5 kg';
                        }),
                    GreenPoolChip(
                        controller: controller,
                        radius: 40.kh,
                        labelText: 'M',
                        selected:
                            controller.selectedCHIP.value == 'M' ? true : false,
                        onPressed: () {
                          controller.selectedCHIP.value = 'M';
                          controller.luggageWeight.value = '10 kg';
                        }),
                    GreenPoolChip(
                        controller: controller,
                        radius: 40.kh,
                        labelText: 'L',
                        selected:
                            controller.selectedCHIP.value == 'L' ? true : false,
                        onPressed: () {
                          controller.selectedCHIP.value = 'L';
                          controller.luggageWeight.value = '15 kg';
                        }),
                  ],
                ),
              ),
              Text(
                'Other',
                style: TextStyleUtil.k16Bold(color: ColorUtil.kNeutral5),
              ).paddingOnly(top: 24.kh, bottom: 16.kh),
              const AmenitiesList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => GreenPoolButton(
                      onPressed: () => controller.moveToPricingView(),
                      padding: const EdgeInsets.all(0),
                      isActive: controller.isActiveCarpoolButton.value,
                      label: 'Next',
                      fontSize: 14.kh,
                      width: 120.kw,
                      height: 40.kh,
                    ).paddingSymmetric(vertical: 40.kh),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

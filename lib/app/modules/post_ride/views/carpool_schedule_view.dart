import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/green_pool_chip.dart';
import 'package:green_pool/app/modules/post_ride/views/pricing_view.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import 'amenities.dart';

class CarpoolScheduleView extends GetView<PostRideController> {
  const CarpoolScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PostRideController());
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
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimaryPinkMode
                            : ColorUtil.kSecondary01),
                    unselectedLabelColor: ColorUtil.kSecondary01,
                    dividerColor: Colors.transparent,
                    indicatorColor: Colors.transparent,
                    overlayColor: MaterialStatePropertyAll(
                        ColorUtil.kSecondary01.withOpacity(0.05)),
                    labelColor: Get.find<ProfileController>().isSwitched.value
                        ? ColorUtil.kBlack01
                        : ColorUtil.kWhiteColor,
                    splashBorderRadius: BorderRadius.circular(80.kh),
                    unselectedLabelStyle: TextStyleUtil.k14Semibold(
                        color: ColorUtil.kSecondary01),
                    labelStyle: TextStyleUtil.k14Semibold(
                        color: Get.find<ProfileController>().isSwitched.value
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

              Text(
                'Enter the specific date and time, specifying  am (morning) or pm (afternoon)',
                style: TextStyleUtil.k16Semibold(
                    fontSize: 16.kh, color: ColorUtil.kBlack02),
              ).paddingOnly(top: 24.kh, bottom: 16.kh),

              Obx(
                () => controller.tabIndex.value == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            //TODO: Calendar select
                            hintText: 'Select date',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                            suffix: SizedBox(
                              child: SvgPicture.asset(
                                ImageConstant.svgIconCalendar,
                                height: 24.kh,
                                width: 24.kw,
                                colorFilter: ColorFilter.mode(
                                    Get.find<ProfileController>()
                                            .isSwitched
                                            .value
                                        ? ColorUtil.kPrimary3PinkMode
                                        : ColorUtil.kSecondary01,
                                    BlendMode.srcIn),
                              ).paddingOnly(right: 16.kw),
                            ),
                            onPressedSuffix: () {
                              showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                  initialDate: DateTime.now());
                            },
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),
                          Text(
                            'Time',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            hintText: 'Select time',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),

                          //RETURN TRIP
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //TODO: toggle switch
                              Text(
                                'Return trip',
                                style:
                                    TextStyleUtil.k16Semibold(fontSize: 16.kh),
                              ),
                              Obx(
                                () => Transform.scale(
                                  scale: 0.8.kh,
                                  child: Switch(
                                    value: controller.isReturn.value,
                                    onChanged: (value) {
                                      controller.isReturn.value = value;
                                    },
                                    inactiveThumbColor: ColorUtil.kNeutral1,
                                    inactiveTrackColor:
                                        Get.find<ProfileController>()
                                                .isSwitched
                                                .value
                                            ? ColorUtil.kSecondaryPinkMode
                                            : ColorUtil.kPrimary05,
                                    activeTrackColor:
                                        Get.find<ProfileController>()
                                                .isSwitched
                                                .value
                                            ? ColorUtil.kPrimary3PinkMode
                                            : ColorUtil.kSecondary01,
                                    trackOutlineWidth:
                                        const MaterialStatePropertyAll(0),
                                    thumbColor: const MaterialStatePropertyAll(
                                        ColorUtil.kWhiteColor),
                                    trackOutlineColor:
                                        const MaterialStatePropertyAll(
                                            ColorUtil.kNeutral1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            //TODO: Calendar select
                            hintText: 'Select date',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                            suffix: SizedBox(
                              child: SvgPicture.asset(
                                ImageConstant.svgIconCalendar,
                                height: 24.kh,
                                width: 24.kw,
                                colorFilter: ColorFilter.mode(
                                    Get.find<ProfileController>()
                                            .isSwitched
                                            .value
                                        ? ColorUtil.kPrimary3PinkMode
                                        : ColorUtil.kSecondary01,
                                    BlendMode.srcIn),
                              ).paddingOnly(right: 16.kw),
                            ),
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),
                          Text(
                            'Time',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            hintText: 'Select time',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),
                          Text(
                            'Returning at Time (same day)',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            hintText: 'Select time',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),
                        ],
                      ),
              ),
              //if return trip then this option
              //TODO: if set on true and then selected recurring trip then it still stays. how to handle that
              Obx(
                () => controller.isReturn.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Select Date and Time of Arrival',
                                style:
                                    TextStyleUtil.k16Semibold(fontSize: 16.kh),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1.kh,
                                  color: ColorUtil.kNeutral2,
                                ).paddingOnly(left: 8.kw),
                              ),
                            ],
                          ).paddingSymmetric(vertical: 16.kh),
                          Text(
                            'Date',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            hintText: 'Select date',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                            suffix: SizedBox(
                              child: SvgPicture.asset(
                                ImageConstant.svgIconCalendar,
                                height: 24.kh,
                                width: 24.kw,
                                colorFilter: ColorFilter.mode(
                                    Get.find<ProfileController>()
                                            .isSwitched
                                            .value
                                        ? ColorUtil.kPrimary3PinkMode
                                        : ColorUtil.kSecondary01,
                                    BlendMode.srcIn),
                              ).paddingOnly(right: 16.kw),
                            ),
                          ).paddingOnly(top: 8.kh, bottom: 16.kh),
                          Text(
                            'Time',
                            style: TextStyleUtil.k14Semibold(),
                          ),
                          GreenPoolTextField(
                            hintText: 'Select time',
                            onTap: () {},
                            obscureText: false,
                            enabled: true,
                          ).paddingOnly(top: 8.kh),
                        ],
                      )
                    : const SizedBox(),
              ),

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
              Text(
                'Number of Seats Available',
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
                            Get.find<ProfileController>().isSwitched.value
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
                                Get.find<ProfileController>().isSwitched.value
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
                            Get.find<ProfileController>().isSwitched.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      )),
                ],
              ).paddingOnly(bottom: 24.kh),
              Text(
                'Luggage Allowance',
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ),
              Text(
                'Luggage Weight : 5 Kg ',
                style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
              ).paddingOnly(top: 4.kh, bottom: 16.kh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'No',
                      selectedChipIndex: 0),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'S',
                      selectedChipIndex: 1),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'M',
                      selectedChipIndex: 2),
                  GreenPoolChip(
                      controller: controller,
                      radius: 40.kh,
                      labelText: 'L',
                      selectedChipIndex: 3),
                ],
              ),
              Text(
                'Other',
                style: TextStyleUtil.k16Bold(color: ColorUtil.kNeutral5),
              ).paddingOnly(top: 24.kh, bottom: 16.kh),

              Amenities(
                text: 'Appreciates Conversation',
                image: ImageConstant.svgAmenities1,
                index: 0,
              ),
              Amenities(
                text: 'Enjoys Music',
                image: ImageConstant.svgAmenities2,
                index: 1,
              ),
              Amenities(
                text: 'Smoke-free',
                image: ImageConstant.svgAmenities3,
                index: 2,
              ),
              Amenities(
                text: 'Pet-friendly',
                image: ImageConstant.svgAmenities4,
                index: 3,
              ),
              Amenities(
                text: 'Winter Tires',
                image: ImageConstant.svgAmenities5,
                index: 4,
              ),
              Amenities(
                text: 'Cooling or Heating',
                image: ImageConstant.svgAmenities6,
                index: 5,
              ),
              Amenities(
                text: 'Baby Seat',
                image: ImageConstant.svgAmenities7,
                index: 6,
              ),
              Amenities(
                text: 'Heated Seats',
                image: ImageConstant.svgAmenities8,
                index: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GreenPoolButton(
                    onPressed: () => Get.to(() => const PricingView()),
                    padding: const EdgeInsets.all(0),
                    label: 'Next',
                    fontSize: 14.kh,
                    width: 120.kw,
                    height: 40.kh,
                  ).paddingSymmetric(vertical: 40.kh),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

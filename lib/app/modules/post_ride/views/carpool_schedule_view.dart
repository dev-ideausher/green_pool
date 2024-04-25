import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/modules/post_ride/controllers/post_ride_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/green_pool_chip.dart';
import 'package:green_pool/app/routes/app_pages.dart';
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
    // Get.lazyPut(() => PostRideController());
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
              Obx(() => controller.tabIndex.value == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter the specific date and time, specifying  am (morning) or pm (afternoon)',
                          style: TextStyleUtil.k16Semibold(
                              fontSize: 16.kh, color: ColorUtil.kBlack02),
                        ).paddingOnly(top: 24.kh, bottom: 16.kh),

                        const RichTextHeading(text: "Date"),
                        GreenPoolTextField(
                            controller: controller.formattedOneTimeDate,
                            hintText: 'Select Date',
                            readOnly: true,
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
                            onTap: () {
                              controller.setDate(context).then((value) =>
                                  controller.setActiveStateCarpoolSchedule());
                            }).paddingOnly(top: 8.kh, bottom: 16.kh),
                        Text(
                          'Time',
                          style: TextStyleUtil.k14Semibold(),
                        ),
                        GreenPoolTextField(
                          hintText: 'Select Time',
                          controller: controller.selectedTimeOneTime,
                          onTap: () {
                            controller.setTime(context);
                          },
                          readOnly: true,
                        ).paddingOnly(top: 8.kh, bottom: 16.kh),

                        //RETURN TRIP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //TODO: toggle switch
                            Text(
                              'Return trip',
                              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
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

                        //if return trip then this option
                        controller.isReturn.value
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Select Date and Time of Arrival',
                                        style: TextStyleUtil.k16Semibold(
                                            fontSize: 16.kh),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 1.kh,
                                          color: ColorUtil.kNeutral2,
                                        ).paddingOnly(left: 8.kw),
                                      ),
                                    ],
                                  ).paddingSymmetric(vertical: 16.kh),
                                  const RichTextHeading(text: "Date"),
                                  GreenPoolTextField(
                                    hintText: 'Select Date',
                                    controller: controller.formattedReturnDate,
                                    onTap: () {
                                      controller.setReturnDate(context);
                                    },
                                    readOnly: true,
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
                                    hintText: 'Select Time',
                                    onTap: () {
                                      controller.setReturnTime(context);
                                    },
                                    readOnly: true,
                                    controller:
                                        controller.selectedTimeReturnTrip,
                                  ).paddingOnly(top: 8.kh),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select the days and time, specifying  am (morning) or pm (afternoon)',
                          style: TextStyleUtil.k16Semibold(
                              fontSize: 16.kh, color: ColorUtil.kBlack02),
                        ).paddingOnly(top: 24.kh, bottom: 16.kh),
                        const RichTextHeading(text: 'Day')
                            .paddingOnly(bottom: 8.kh),
                        Obx(
                          () => Row(
                            // recurring days selection
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Mon',
                                  selected: controller.isMonday.value,
                                  onPressed: () {
                                    controller.isMonday.value =
                                        !controller.isMonday.value;
                                    controller.isMonday.value
                                        ? controller.addDays(1)
                                        : controller.removeDays(1);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Tue',
                                  selected: controller.isTuesday.value,
                                  onPressed: () {
                                    controller.isTuesday.value =
                                        !controller.isTuesday.value;
                                    controller.isTuesday.value
                                        ? controller.addDays(2)
                                        : controller.removeDays(2);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Wed',
                                  selected: controller.isWednesday.value,
                                  onPressed: () {
                                    controller.isWednesday.value =
                                        !controller.isWednesday.value;
                                    controller.isWednesday.value
                                        ? controller.addDays(3)
                                        : controller.removeDays(3);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Thu',
                                  selected: controller.isThursDay.value,
                                  onPressed: () {
                                    controller.isThursDay.value =
                                        !controller.isThursDay.value;
                                    controller.isThursDay.value
                                        ? controller.addDays(4)
                                        : controller.removeDays(4);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Fri ',
                                  selected: controller.isFriday.value,
                                  onPressed: () {
                                    controller.isFriday.value =
                                        !controller.isFriday.value;
                                    controller.isFriday.value
                                        ? controller.addDays(5)
                                        : controller.removeDays(5);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Sat',
                                  selected: controller.isSaturday.value,
                                  onPressed: () {
                                    controller.isSaturday.value =
                                        !controller.isSaturday.value;
                                    controller.isSaturday.value
                                        ? controller.addDays(6)
                                        : controller.removeDays(6);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                              GreenPoolChip(
                                  controller: controller,
                                  radius: 8.kh,
                                  label: const SizedBox(),
                                  textPadding: 0.0.kh,
                                  padding: EdgeInsets.all(0.kh),
                                  labelText: 'Sun',
                                  selected: controller.isSunday.value,
                                  onPressed: () {
                                    controller.isSunday.value =
                                        !controller.isSunday.value;
                                    controller.isSunday.value
                                        ? controller.addDays(7)
                                        : controller.removeDays(7);
                                    controller.setActiveStateCarpoolSchedule();
                                  }),
                            ],
                          ).paddingOnly(bottom: 8.kh),
                        ),
                        Text(
                          'Time',
                          style: TextStyleUtil.k14Semibold(),
                        ),
                        GreenPoolTextField(
                          hintText: 'Select Time',
                          controller: controller.selectedRecurringTime,
                          onTap: () {
                            controller.setRecurringTime(context);
                          },
                          readOnly: true,
                        ).paddingOnly(top: 8.kh, bottom: 16.kh),
                      ],
                    )),

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
              RichTextHeading(
                text: 'Luggage Allowance',
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      'Luggage Weight : ${"${controller.selectedCHIP.value} ${controller.luggageWeight.value}"}',
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

                          controller.luggageWeight.value = '';
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
              Obx(
                () => Column(
                  children: [
                    Amenities(
                        text: 'Appreciates Conversation',
                        image: ImageConstant.svgAmenities1,
                        value: controller.appreciatesConversation.value,
                        onChanged: (val) {
                          controller.appreciatesConversation.value = val;
                        }),
                    Amenities(
                      text: 'Enjoys Music',
                      image: ImageConstant.svgAmenities2,
                      value: controller.enjoysMusic.value,
                      onChanged: (val) {
                        controller.enjoysMusic.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Smoke-free',
                      image: ImageConstant.svgAmenities3,
                      value: controller.smokeFree.value,
                      onChanged: (val) {
                        controller.smokeFree.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Pet-friendly',
                      image: ImageConstant.svgAmenities4,
                      value: controller.petFriendly.value,
                      onChanged: (val) {
                        controller.petFriendly.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Winter Tires',
                      image: ImageConstant.svgAmenities5,
                      value: controller.winterTires.value,
                      onChanged: (val) {
                        controller.winterTires.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Cooling or Heating',
                      image: ImageConstant.svgAmenities6,
                      value: controller.coolingOrHeating.value,
                      onChanged: (val) {
                        controller.coolingOrHeating.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Baby Seat',
                      image: ImageConstant.svgAmenities7,
                      value: controller.babySeat.value,
                      onChanged: (val) {
                        controller.babySeat.value = val;
                      },
                    ),
                    Amenities(
                      text: 'Heated Seats',
                      image: ImageConstant.svgAmenities8,
                      value: controller.heatedSeats.value,
                      onChanged: (val) {
                        controller.heatedSeats.value = val;
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => GreenPoolButton(
                      onPressed: () => Get.toNamed(Routes.PRICING_VIEW),
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

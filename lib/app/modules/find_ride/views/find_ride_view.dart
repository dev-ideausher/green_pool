import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';

import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../origin/controllers/origin_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/find_ride_controller.dart';

class FindRideView extends GetView<FindRideController> {
  const FindRideView({super.key});

  @override
  Widget build(BuildContext context) {
    final pickedDate = DateTime.now();
    controller.date.text = pickedDate.toIso8601String();
    controller.departureDate.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.findRide),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTextHeading(text: Strings.pickup).paddingOnly(top: 12.kh),
              GreenPoolTextField(
                hintText: Strings.enterOrigin,
                keyboardType: TextInputType.streetAddress,
                onchanged: (v) {
                  controller.setActiveState();
                },
                onTap: () {
                  Get.toNamed(Routes.ORIGIN,
                          arguments: LocationValues.findRideOrigin)
                      ?.then((v) => controller.setActiveState());
                  ;
                },
                controller: controller.riderOriginTextController,
                readOnly: true,
                prefix: Icon(
                  Icons.location_on,
                  size: 24.kh,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ).paddingOnly(top: 8.kh, bottom: 16.kh),
              RichTextHeading(text: Strings.destination),
              GreenPoolTextField(
                hintText: Strings.enterAdestination,
                keyboardType: TextInputType.streetAddress,
                onchanged: (v) {
                  controller.setActiveState();
                },
                onTap: () {
                  Get.toNamed(Routes.ORIGIN,
                          arguments: LocationValues.findRideDestination)
                      ?.then((v) => controller.setActiveState());
                },
                controller: controller.riderDestinationTextController,
                prefix: Icon(
                  Icons.location_on,
                  size: 24.kh,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
                readOnly: true,
              ).paddingOnly(top: 8.kh, bottom: 16.kh),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.departureDateAndTime,
                      style: TextStyleUtil.k14Semibold(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 55.w,
                    child: GreenPoolTextField(
                      hintText: Strings.enterDate,
                      controller: controller.departureDate,
                      isSuffixNeeded: false,
                      readOnly: true,
                      onTap: () {
                        controller.setDate(context);
                      },
                      prefix: SvgPicture.asset(
                        ImageConstant.svgIconCalendarClear,
                        colorFilter: ColorFilter.mode(
                            Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ),
                    ).paddingOnly(top: 8.kh, bottom: 16.kh, right: 8.kw),
                  ),
                  Flexible(
                    child: GreenPoolTextField(
                      hintText: Strings.time,
                      controller: controller.selectedTime,
                      isSuffixNeeded: false,
                      readOnly: true,
                      onTap: () {
                        controller.setTime(context);
                      },
                      prefix: SvgPicture.asset(
                        ImageConstant.svgIconTime,
                        colorFilter: ColorFilter.mode(
                            Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ),
                    ).paddingOnly(top: 8.kh, bottom: 16.kh),
                  ),
                ],
              ).paddingOnly(bottom: 16.kh),
              RichTextHeading(text: Strings.seatsAvailable)
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: Strings.enterNumberOfSeats,
                controller: controller.seatAvailable,
                keyboardType: TextInputType.number,
                onchanged: (v) {
                  controller.setActiveState();
                },
                prefix: Icon(
                  Icons.time_to_leave,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ).paddingOnly(bottom: 16.kh),
              Text(
                Strings.description,
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: Strings.enterTextHere,
                controller: controller.descriptionTextController,
                maxLines: 6,
              ),
              // const Expanded(child: SizedBox()),
              GreenPoolButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => controller.decideRouting(),
                isActive: controller.isActive.value,
                label: Strings.findMatchingRides,
              ).paddingSymmetric(vertical: 40.kh),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

//! contains matching drivers after Find A Ride page
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/find_ride/controllers/find_ride_controller.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/matching_rides_controller.dart';

class MatchingRidesView extends GetView<MatchingRidesController> {
  const MatchingRidesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: const Text('Matching Rides'),
        actions: [
          GestureDetector(
            onTap: () {
              controller.moveToFilter();
            },
            child: SvgPicture.asset(ImageConstant.svgIconFilter)
                .paddingOnly(right: 16.kw),
          ),
        ],
      ),
      bottomSheet: Container(
        color: ColorUtil.kBackgroundColor,
        child: GreenPoolButton(
          onPressed: () async {
            try {
              await Get.find<FindRideController>().riderPostRideAPI();

              await Get.bottomSheet(
                Container(
                    padding: EdgeInsets.all(24.kh),
                    height: 390.kh,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: ColorUtil.kWhiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.kh),
                            topRight: Radius.circular(40.kh))),
                    child: Column(
                      children: [
                        Text(
                          'Request Alert Created\nSuccessfully!',
                          style: TextStyleUtil.k18Heading600(),
                          textAlign: TextAlign.center,
                        ).paddingOnly(bottom: 24.kh),
                        SvgPicture.asset(
                          ImageConstant.svgCompleteTick,
                          height: 64.kh,
                          width: 64.kw,
                        ).paddingOnly(bottom: 16.kh),
                        Text(
                          "Ride alert created succesfully!",
                          textAlign: TextAlign.center,
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 4.kh),
                        Text(
                          "The matching ride alert will be sent to you shortly.",
                          textAlign: TextAlign.center,
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ).paddingOnly(bottom: 40.kh),
                        GreenPoolButton(
                            label: 'Continue',
                            onPressed: () {
                              Get.until((route) =>
                                  Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                            }),
                      ],
                    )),
              );
            } catch (e) {
              throw Exception(e);
            }
          },
          label: "Create a ride alert",
        ).paddingOnly(bottom: 24.kh),
      ),
      body: Obx(
        () => controller.matchingRidesModel.value.data == null
            ? const GpProgress()
            : (controller.matchingRidesModel.value.data?.length ?? 0) == 0
                ? Center(
                    child: Text(
                      'No rides available',
                      style: TextStyleUtil.k18Heading600(),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller
                                .matchingRidesModel.value.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.moveToDriverDetails(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.kh),
                                  decoration: BoxDecoration(
                                      color: ColorUtil.kWhiteColor,
                                      borderRadius:
                                          BorderRadius.circular(8.kh)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          //for profile pic and rating
                                          Stack(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.kh),
                                                    child: CommonImageView(
                                                        height: 64.kh,
                                                        width: 64.kw,
                                                        url:
                                                            "${controller.matchingRidesModel.value.data![index]?.driverDetails![0]?.profilePic?.url}")),
                                              ).paddingOnly(bottom: 8.kh),
                                              Positioned(
                                                top: 52.kh,
                                                left: 8.kw,
                                                child: Container(
                                                  width: 48.kw,
                                                  height: 20.kh,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.kw),
                                                  decoration: BoxDecoration(
                                                      color: Get.find<
                                                                  HomeController>()
                                                              .isPinkModeOn
                                                              .value
                                                          ? ColorUtil
                                                              .kPrimary3PinkMode
                                                          : ColorUtil
                                                              .kSecondary01,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.kh)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Get.find<
                                                                    HomeController>()
                                                                .isPinkModeOn
                                                                .value
                                                            ? ColorUtil
                                                                .kWhiteColor
                                                            : ColorUtil
                                                                .kYellowColor,
                                                        size: 12.kh,
                                                      ).paddingOnly(
                                                          right: 2.kw),
                                                      Text(
                                                        // '0.0',
                                                        controller
                                                                .matchingRidesModel
                                                                .value
                                                                .data?[index]
                                                                ?.driverDetails?[
                                                                    0]
                                                                ?.rating
                                                                .toString() ??
                                                            '0.0',
                                                        style: TextStyleUtil.k12Semibold(
                                                            color: Get.find<
                                                                        HomeController>()
                                                                    .isPinkModeOn
                                                                    .value
                                                                ? ColorUtil
                                                                    .kBlack02
                                                                : ColorUtil
                                                                    .kWhiteColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).paddingOnly(
                                              right: 16.kw, bottom: 16.kh),
                                          //for name and date
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      // 'Sam Alexander',
                                                      "${controller.matchingRidesModel.value.data![index]?.driverDetails![0]?.fullName}",
                                                      style: TextStyleUtil
                                                          .k16Bold(),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            // text: '\$3.50',
                                                            text:
                                                                "\$ ${controller.matchingRidesModel.value.data![index]?.origin?.originDestinationFair}",
                                                            style: TextStyleUtil
                                                                .k16Bold(
                                                                    color: ColorUtil
                                                                        .kSecondary01),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          ImageConstant
                                                              .svgIconCalendarTime,
                                                          colorFilter: ColorFilter.mode(
                                                              Get.find<HomeController>()
                                                                      .isPinkModeOn
                                                                      .value
                                                                  ? ColorUtil
                                                                      .kPrimary3PinkMode
                                                                  : ColorUtil
                                                                      .kSecondary01,
                                                              BlendMode.srcIn),
                                                        ).paddingOnly(
                                                            right: 4.kw),
                                                        Text(
                                                          // '07 Nov 2023, 3:00pm',
                                                          "${controller.matchingRidesModel.value.data![index]?.date?.split("T")[0]} ${controller.matchingRidesModel.value.data![index]?.time}",
                                                          style: TextStyleUtil
                                                              .k12Regular(
                                                                  color: ColorUtil
                                                                      .kBlack03),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.time_to_leave,
                                                          size: 18.kh,
                                                          color: Get.find<
                                                                      HomeController>()
                                                                  .isPinkModeOn
                                                                  .value
                                                              ? ColorUtil
                                                                  .kPrimary3PinkMode
                                                              : ColorUtil
                                                                  .kSecondary01,
                                                        ).paddingOnly(
                                                            right: 8.kw),
                                                        Text(
                                                          '${controller.matchingRidesModel.value.data![index]?.seatAvailable ?? "0"} seats',
                                                          style: TextStyleUtil
                                                              .k14Regular(
                                                                  color: ColorUtil
                                                                      .kBlack03),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      //middle divider
                                      const GreenPoolDivider()
                                          .paddingOnly(bottom: 16.kh),
                                      OriginToDestination(
                                        origin:
                                            "${controller.matchingRidesModel.value.data![index]?.origin?.name}",
                                        destination:
                                            "${controller.matchingRidesModel.value.data![index]?.destination?.name}",
                                        needPickupText: false,
                                      ).paddingOnly(bottom: 8.kh),
                                      //bottom line
                                      const GreenPoolDivider(),
                                    ],
                                  ),
                                ).paddingOnly(bottom: 16.kh),
                              );
                            }).paddingOnly(top: 32.kh),
                      ),
                    ],
                  ).paddingOnly(left: 16.kw, right: 16.kw, bottom: 80.kh),
      ),
    );
  }
}

//! contains matching drivers after Find A Ride page
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../res/strings.dart';
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
            controller.createRideAlert();
          },
          label: Strings.createRideAlert,
        ).paddingOnly(bottom: 24.kh),
      ),
      body: Obx(
        () => RefreshIndicator(
          backgroundColor: ColorUtil.kWhiteColor,
          color: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kPrimary01,
          onRefresh: () async {
            await controller.getMatchingRidesAPI();
          },
          child: controller.isLoading.value
              ? const GpProgress()
              : (controller.matchingRidesModel.value.data?.length ?? 0) == 0
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        alignment: Alignment.center,
                        child: Text(
                          'No rides available',
                          style: TextStyleUtil.k18Heading600(),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: controller
                                  .matchingRidesModel.value.data?.length,
                              itemBuilder: (context, index) {
                                return (controller
                                            .matchingRidesModel
                                            .value
                                            .data![index]
                                            ?.driverDetails
                                            ?.isEmpty ??
                                        true)
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          controller.moveToDriverDetails(index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16.kh),
                                          decoration: BoxDecoration(
                                              color: ColorUtil.kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.kh),
                                              border: Border.all(
                                                  width: 0.3.kh,
                                                  color: ColorUtil.kNeutral10)),
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
                                                                BorderRadius
                                                                    .circular(
                                                                        8.kh),
                                                            child: CommonImageView(
                                                                height: 64.kh,
                                                                width: 64.kw,
                                                                url:
                                                                    "${controller.matchingRidesModel.value.data![index]?.driverDetails![0]?.profilePic?.url}")),
                                                      ).paddingOnly(
                                                          bottom: 8.kh),
                                                      Positioned(
                                                        top: 52.kh,
                                                        left: 8.kw,
                                                        child: Container(
                                                          width: 48.kw,
                                                          height: 20.kh,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      8.kw),
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
                                                                  BorderRadius
                                                                      .circular(
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
                                                                        .data?[
                                                                            index]
                                                                        ?.driverDetails?[
                                                                            0]
                                                                        ?.rating
                                                                        .toString() ??
                                                                    '0.0',
                                                                style: TextStyleUtil.k12Semibold(
                                                                    color: Get.find<HomeController>()
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
                                                      right: 16.kw,
                                                      bottom: 16.kh),
                                                  //for name and date
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              // 'Sam Alexander',
                                                              "${controller.matchingRidesModel.value.data![index]?.driverDetails![0]?.fullName}",
                                                              style:
                                                                  TextStyleUtil
                                                                      .k16Bold(),
                                                            ),
                                                            Text.rich(
                                                              TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    // text: '\$3.50',
                                                                    text:
                                                                        "\$ ${controller.matchingRidesModel.value.data![index]?.price}",
                                                                    style: TextStyleUtil
                                                                        .k16Bold(
                                                                            color:
                                                                                ColorUtil.kSecondary01),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ).paddingOnly(
                                                            bottom: 8.kh),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    ImageConstant
                                                                        .svgIconCalendarTime,
                                                                    colorFilter: ColorFilter.mode(
                                                                        Get.find<HomeController>().isPinkModeOn.value
                                                                            ? ColorUtil
                                                                                .kPrimary3PinkMode
                                                                            : ColorUtil
                                                                                .kSecondary01,
                                                                        BlendMode
                                                                            .srcIn),
                                                                  ).paddingOnly(
                                                                      right:
                                                                          4.kw),
                                                                  Text(
                                                                    "${GpUtil.getDateFormat(controller.matchingRidesModel.value.data![index]?.time ?? "")} ${GpUtil.convertUtcToLocal(controller.matchingRidesModel.value.data![index]?.time ?? "")}",
                                                                    style: TextStyleUtil
                                                                        .k12Regular(
                                                                            color:
                                                                                ColorUtil.kBlack03),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .time_to_leave,
                                                                  size: 16.kh,
                                                                  color: Get.find<
                                                                              HomeController>()
                                                                          .isPinkModeOn
                                                                          .value
                                                                      ? ColorUtil
                                                                          .kPrimary3PinkMode
                                                                      : ColorUtil
                                                                          .kSecondary01,
                                                                ).paddingOnly(
                                                                    right:
                                                                        4.kw),
                                                                Text(
                                                                  '${controller.matchingRidesModel.value.data![index]?.seatAvailable ?? "0"} seats',
                                                                  style: TextStyleUtil
                                                                      .k14Regular(
                                                                          color:
                                                                              ColorUtil.kBlack03),
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
                                                  .paddingOnly(bottom: 8.kh),
                                              OriginToDestination(
                                                origin:
                                                    "${controller.matchingRidesModel.value.data![index]?.matchedOriginLocation?.name}",
                                                destination:
                                                    "${controller.matchingRidesModel.value.data![index]?.matchedDestinationLocation?.name}",
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
      ),
    );
  }
}

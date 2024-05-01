//! contains my rides view (driver tile and rider tile)

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../my_rides_page/controllers/my_rides_page_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_one_time_controller.dart';

class MyRidesOneTimeView extends GetView<MyRidesOneTimeController> {
  const MyRidesOneTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesOneTimeController());
    controller.myRidesAPI();
    return Scaffold(
      body: SafeArea(
        child: Get.find<GetStorageService>().getLoggedIn
            ? Obx(
                () => controller.isLoad.value
                    ? const GpProgress()
                    : controller.myRidesModelData.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: SvgPicture.asset(
                                      ImageConstant.svgNoRides)),
                              Text(
                                "You have posted no rides",
                                style: TextStyleUtil.k24Heading600(),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Obx(
                                () => Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        controller.myRidesModelData?.length,
                                    itemBuilder: (context, index) {
                                      if (controller.myRidesModelData[index]
                                              ?.driverId !=
                                          null) {
                                        return
                                            // --------------- for driver tile -----------------//
                                            GestureDetector(
                                          onTap: () {
                                            controller.viewDetails(controller
                                                .myRidesModelData[index]!);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.kh),
                                            decoration: BoxDecoration(
                                                color: ColorUtil.kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.kh),
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            ColorUtil.kNeutral7,
                                                        width: 2.kh))),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    controller
                                                                .myRidesModelData[
                                                                    index]
                                                                ?.time ==
                                                            ""
                                                        ? Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                ImageConstant
                                                                    .svgIconCalendarTime,
                                                                colorFilter: ColorFilter.mode(
                                                                    Get.find<HomeController>()
                                                                            .isSwitched
                                                                            .value
                                                                        ? ColorUtil
                                                                            .kPrimary3PinkMode
                                                                        : ColorUtil
                                                                            .kSecondary01,
                                                                    BlendMode
                                                                        .srcIn),
                                                              ).paddingOnly(
                                                                  right: 4.kw),
                                                              Text(
                                                                // '07 November 2023',
                                                                controller
                                                                        .myRidesModelData[
                                                                            index]
                                                                        ?.date
                                                                        ?.split(
                                                                            'T')[0] ??
                                                                    "",
                                                                style: TextStyleUtil
                                                                    .k12Regular(
                                                                        color: ColorUtil
                                                                            .kBlack03),
                                                              ),
                                                            ],
                                                          ).paddingOnly(
                                                            bottom: 8.kh)
                                                        : Text(
                                                            // '10:30 am',
                                                            "${controller.myRidesModelData[index]?.time}",
                                                            style: TextStyleUtil
                                                                .k16Bold(),
                                                          ),
                                                    SizedBox(
                                                      height: 24.kh,
                                                      width: 170.kw,
                                                      child: ListView.builder(
                                                        itemCount: (controller
                                                                        .myRidesModelData[
                                                                            index]
                                                                        ?.postsInfo
                                                                        ?.length ??
                                                                    0) ==
                                                                0
                                                            ? 4
                                                            : controller
                                                                .myRidesModelData[
                                                                    index]
                                                                ?.postsInfo
                                                                ?.length,
                                                        reverse: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index1) {
                                                          return Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: ClipOval(
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: Size
                                                                    .fromRadius(
                                                                        12.kh),
                                                                child: controller
                                                                            .myRidesModelData[
                                                                                index]
                                                                            ?.postsInfo
                                                                            ?.length ==
                                                                        0
                                                                    ? Image
                                                                        .asset(
                                                                        ImageConstant
                                                                            .pngEmptyPassenger,
                                                                      )
                                                                    : Image(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(
                                                                            "${controller.myRidesModelData[index]?.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.profilePic?.url}"),
                                                                      ),
                                                              ),
                                                            ),
                                                          ).paddingOnly(
                                                              right: 4.kw);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),

                                                //-------------------- if rider has done "Find a Ride" and has not selected any time ----------------

                                                controller
                                                            .myRidesModelData[
                                                                index]
                                                            ?.time ==
                                                        ""
                                                    ? const SizedBox()
                                                    : Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            ImageConstant
                                                                .svgIconCalendarTime,
                                                            colorFilter: ColorFilter.mode(
                                                                Get.find<HomeController>()
                                                                        .isSwitched
                                                                        .value
                                                                    ? ColorUtil
                                                                        .kPrimary3PinkMode
                                                                    : ColorUtil
                                                                        .kSecondary01,
                                                                BlendMode
                                                                    .srcIn),
                                                          ).paddingOnly(
                                                              right: 4.kw),
                                                          Text(
                                                            // '07 November 2023',
                                                            controller
                                                                    .myRidesModelData[
                                                                        index]
                                                                    ?.date
                                                                    ?.split(
                                                                        'T')[0] ??
                                                                "",
                                                            style: TextStyleUtil
                                                                .k12Regular(
                                                                    color: ColorUtil
                                                                        .kBlack03),
                                                          ),
                                                        ],
                                                      ).paddingOnly(
                                                        bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                OriginToDestination(
                                                  needPickupText: false,
                                                  origin: controller
                                                          .myRidesModelData[
                                                              index]
                                                          ?.origin
                                                          ?.name ??
                                                      'Origin',
                                                  destination: controller
                                                          .myRidesModelData[
                                                              index]
                                                          ?.destination
                                                          ?.name ??
                                                      'Destination',
                                                ).paddingOnly(bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                Obx(
                                                  () => controller
                                                              .myRidesModelData[
                                                                  index]
                                                              ?.isCancelled ==
                                                          true
                                                      ? Text(
                                                          "Ride is cancelled",
                                                          style: TextStyleUtil
                                                              .k16Bold(
                                                                  color: ColorUtil
                                                                      .kError2),
                                                        )
                                                      : controller
                                                                      .myRidesModelData[
                                                                          index]
                                                                      ?.date ==
                                                                  "" ||
                                                              controller
                                                                      .myRidesModelData[
                                                                          index]
                                                                      ?.date ==
                                                                  null
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                GreenPoolButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller.viewDetails(
                                                                        controller
                                                                            .myRidesModelData[index]!);
                                                                  },
                                                                  width: 144.kw,
                                                                  height: 40.kh,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .kh),
                                                                  fontSize:
                                                                      14.kh,
                                                                  borderColor: Get.find<
                                                                              HomeController>()
                                                                          .isSwitched
                                                                          .value
                                                                      ? ColorUtil
                                                                          .kPrimary3PinkMode
                                                                      : ColorUtil
                                                                          .kSecondary01,
                                                                  labelColor: Get.find<
                                                                              HomeController>()
                                                                          .isSwitched
                                                                          .value
                                                                      ? ColorUtil
                                                                          .kPrimary3PinkMode
                                                                      : ColorUtil
                                                                          .kSecondary01,
                                                                  label:
                                                                      "View details",
                                                                ),
                                                                GreenPoolButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller.cancelRideAPI(
                                                                        controller
                                                                            .myRidesModelData[index]!);
                                                                  },
                                                                  width: 144.kw,
                                                                  height: 40.kh,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .kh),
                                                                  fontSize:
                                                                      14.kh,
                                                                  isBorder:
                                                                      true,
                                                                  borderColor: Get.find<
                                                                              HomeController>()
                                                                          .isSwitched
                                                                          .value
                                                                      ? ColorUtil
                                                                          .kPrimary3PinkMode
                                                                      : ColorUtil
                                                                          .kSecondary01,
                                                                  labelColor: Get.find<
                                                                              HomeController>()
                                                                          .isSwitched
                                                                          .value
                                                                      ? ColorUtil
                                                                          .kPrimary3PinkMode
                                                                      : ColorUtil
                                                                          .kSecondary01,
                                                                  label:
                                                                      'Cancel Ride',
                                                                ),
                                                              ],
                                                            )
                                                          : isToday(controller
                                                                      .myRidesModelData[
                                                                          index]
                                                                      ?.date ??
                                                                  "")
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    GreenPoolButton(
                                                                        onPressed:
                                                                            () {
                                                                          controller.startRide(controller
                                                                              .myRidesModelData
                                                                              .value[index]);
                                                                        },
                                                                        width: 144
                                                                            .kw,
                                                                        height: 40
                                                                            .kh,
                                                                        padding:
                                                                            EdgeInsets.all(8
                                                                                .kh),
                                                                        fontSize: 14
                                                                            .kh,
                                                                        label:
                                                                            'Start Ride'),
                                                                    GreenPoolButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .cancelRideAPI(controller.myRidesModelData[index]!);
                                                                      },
                                                                      width: 144
                                                                          .kw,
                                                                      height:
                                                                          40.kh,
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .kh),
                                                                      fontSize:
                                                                          14.kh,
                                                                      isBorder:
                                                                          true,
                                                                      borderColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      labelColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      label:
                                                                          'Cancel Ride',
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    GreenPoolButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .viewDetails(controller.myRidesModelData[index]!);
                                                                      },
                                                                      width: 144
                                                                          .kw,
                                                                      height:
                                                                          40.kh,
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .kh),
                                                                      fontSize:
                                                                          14.kh,
                                                                      borderColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      labelColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      label:
                                                                          "View details",
                                                                    ),
                                                                    GreenPoolButton(
                                                                      onPressed:
                                                                          () {
                                                                        controller
                                                                            .cancelRideAPI(controller.myRidesModelData[index]!);
                                                                      },
                                                                      width: 144
                                                                          .kw,
                                                                      height:
                                                                          40.kh,
                                                                      padding: EdgeInsets
                                                                          .all(8
                                                                              .kh),
                                                                      fontSize:
                                                                          14.kh,
                                                                      isBorder:
                                                                          true,
                                                                      borderColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      labelColor: Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      label:
                                                                          'Cancel Ride',
                                                                    ),
                                                                  ],
                                                                ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 16.kh),
                                        );
                                      } else {
                                        return
                                            //---------------- for rider tile ------------------//
                                            GestureDetector(
                                          onTap: () => controller
                                              .riderPagePageOpen(controller
                                                  .myRidesModelData[index]!),
                                          child: Container(
                                            padding: EdgeInsets.all(16.kh),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.kh),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // ---------------- if rider and driver both have confirmed the ride ------------------- //
                                                controller
                                                            .myRidesModelData[
                                                                index]!
                                                            .rideStatus ==
                                                        "Confirmed"
                                                    ? Row(
                                                        children: [
                                                          //for profile pic and rating
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 64.kh,
                                                                width: 64.kw,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.kh),
                                                                  child: Image(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        "${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url}"),
                                                                  ),
                                                                ),
                                                              ).paddingOnly(
                                                                  bottom: 8.kh),
                                                              Positioned(
                                                                top: 52.kh,
                                                                left: 8.kw,
                                                                child:
                                                                    Container(
                                                                  width: 48.kw,
                                                                  height: 20.kh,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8.kw),
                                                                  decoration: BoxDecoration(
                                                                      color: Get.find<HomeController>()
                                                                              .isSwitched
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
                                                                        Icons
                                                                            .star,
                                                                        color: Get.find<HomeController>().isSwitched.value
                                                                            ? ColorUtil.kWhiteColor
                                                                            : ColorUtil.kYellowColor,
                                                                        size: 12
                                                                            .kh,
                                                                      ).paddingOnly(
                                                                          right:
                                                                              2.kw),
                                                                      Text(
                                                                        // '4.5',
                                                                        "${controller.myRidesModelData.value?[index]?.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.rating}",
                                                                        style: TextStyleUtil.k12Semibold(
                                                                            color: Get.find<HomeController>().isSwitched.value
                                                                                ? ColorUtil.kBlack02
                                                                                : ColorUtil.kWhiteColor),
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
                                                                      // 'Savannah Nguyen',
                                                                      "${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName}",
                                                                      style: TextStyleUtil
                                                                          .k16Bold(),
                                                                    ),
                                                                    Text.rich(
                                                                      TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                'Fare: ',
                                                                            style:
                                                                                TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                '\$ ${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.origin?.originDestinationFair}',
                                                                            style:
                                                                                TextStyleUtil.k16Semibold(fontSize: 16.kh, color: ColorUtil.kSecondary01),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ).paddingOnly(
                                                                    bottom:
                                                                        8.kh),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          ImageConstant
                                                                              .svgIconCalendarTime,
                                                                          colorFilter: ColorFilter.mode(
                                                                              Get.find<HomeController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                              BlendMode.srcIn),
                                                                        ).paddingOnly(
                                                                            right:
                                                                                4.kw),
                                                                        Text(
                                                                          // '07 Nov 2023, 3:00pm',
                                                                          '${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData[index]?.time ?? " "}',
                                                                          style:
                                                                              TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .time_to_leave,
                                                                          size:
                                                                              18.kh,
                                                                          color: Get.find<HomeController>().isSwitched.value
                                                                              ? ColorUtil.kPrimary3PinkMode
                                                                              : ColorUtil.kSecondary01,
                                                                        ).paddingOnly(
                                                                            right:
                                                                                8.kw),
                                                                        Text(
                                                                          '${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.seatAvailable} seats',
                                                                          style:
                                                                              TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),

                                                // time view if not confirmed by rider
                                                controller
                                                            .myRidesModelData[
                                                                index]!
                                                            .rideStatus !=
                                                        "Confirmed"
                                                    ? Row(
                                                        children: [
                                                          // ----------- if rider has not seleted any date while doing "Find a Ride" -------------//
                                                          controller
                                                                      .myRidesModelData[
                                                                          index]
                                                                      ?.date ==
                                                                  null
                                                              ? const SizedBox()
                                                              : SvgPicture
                                                                  .asset(
                                                                  ImageConstant
                                                                      .svgIconCalendarTime,
                                                                  colorFilter: ColorFilter.mode(
                                                                      Get.find<HomeController>()
                                                                              .isSwitched
                                                                              .value
                                                                          ? ColorUtil
                                                                              .kPrimary3PinkMode
                                                                          : ColorUtil
                                                                              .kSecondary01,
                                                                      BlendMode
                                                                          .srcIn),
                                                                ).paddingOnly(
                                                                  right: 4.kw),
                                                          controller
                                                                      .myRidesModelData[
                                                                          index]
                                                                      ?.date ==
                                                                  null
                                                              ? const SizedBox()
                                                              : Text(
                                                                  // '07 Nov 2023, 3:00pm',
                                                                  '${controller.myRidesModelData[index]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData[index]?.time ?? " "}',
                                                                  style: TextStyleUtil
                                                                      .k16Bold(),
                                                                ),
                                                        ],
                                                      ).paddingOnly(
                                                        bottom: 16.kh)
                                                    : const SizedBox(),
                                                //middle divider
                                                controller
                                                            .myRidesModelData[
                                                                index]
                                                            ?.date ==
                                                        null
                                                    ? const SizedBox()
                                                    : const GreenPoolDivider()
                                                        .paddingOnly(
                                                            bottom: 16.kh),
                                                OriginToDestination(
                                                        needPickupText: true,
                                                        origin:
                                                            "${controller.myRidesModelData[index]?.origin?.name}",
                                                        destination:
                                                            "${controller.myRidesModelData[index]?.destination?.name}")
                                                    .paddingOnly(bottom: 8.kh),

                                                // view details button and cancel ride button
                                                controller
                                                            .myRidesModelData[
                                                                index]!
                                                            .rideStatus !=
                                                        "Confirmed"
                                                    ? const SizedBox()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GreenPoolButton(
                                                            height: 40.kh,
                                                            width: 144.kw,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.kh),
                                                            onPressed: () {
                                                              controller.riderPagePageOpen(
                                                                  controller
                                                                          .myRidesModelData[
                                                                      index]!);
                                                            },
                                                            label:
                                                                'View Details',
                                                            fontSize: 14.kh,
                                                            borderColor: Get.find<
                                                                        HomeController>()
                                                                    .isSwitched
                                                                    .value
                                                                ? ColorUtil
                                                                    .kPrimary3PinkMode
                                                                : ColorUtil
                                                                    .kSecondary01,
                                                            labelColor: Get.find<
                                                                        HomeController>()
                                                                    .isSwitched
                                                                    .value
                                                                ? ColorUtil
                                                                    .kPrimary3PinkMode
                                                                : ColorUtil
                                                                    .kSecondary01,
                                                          ),
                                                          GreenPoolButton(
                                                            height: 40.kh,
                                                            width: 144.kw,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.kh),
                                                            onPressed: () {
                                                              controller.riderCancelRideAPI(
                                                                  controller
                                                                          .myRidesModelData[
                                                                      index]!);
                                                            },
                                                            isBorder: true,
                                                            label:
                                                                'Cancel Ride',
                                                            fontSize: 14.kh,
                                                            borderColor: Get.find<
                                                                        HomeController>()
                                                                    .isSwitched
                                                                    .value
                                                                ? ColorUtil
                                                                    .kPrimary3PinkMode
                                                                : ColorUtil
                                                                    .kSecondary01,
                                                            labelColor: Get.find<
                                                                        HomeController>()
                                                                    .isSwitched
                                                                    .value
                                                                ? ColorUtil
                                                                    .kPrimary3PinkMode
                                                                : ColorUtil
                                                                    .kSecondary01,
                                                          ),
                                                        ],
                                                      ),
                                              ],
                                            ).paddingOnly(bottom: 16.kh),
                                          ).paddingOnly(bottom: 16.kh),
                                        );
                                      }
                                    },
                                  ).paddingOnly(top: 32.kh),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 16.kw),
              )
            : Center(
                child: Text(
                  'Please Login or SignUp',
                  style: TextStyleUtil.k24Heading600(),
                ),
              ),
      ),
    );
  }

  bool isToday(String s) {
    DateTime dateTime = DateTime.parse(s).toLocal();
    DateTime now = DateTime.now().toLocal();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}

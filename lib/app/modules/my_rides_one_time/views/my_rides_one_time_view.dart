//! contains my rides view (driver tile and rider tile)

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';

import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';

import '../../../components/green_pool_divider.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_controller.dart';

class MyRidesOneTimeView extends GetView<MyRidesOneTimeController> {
  const MyRidesOneTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesOneTimeController());
    return Scaffold(
      body: SafeArea(
        child: Get.find<GetStorageService>().getLoggedIn
            ? Obx(
                () => controller.myRidesModel.value.data == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kPrimary01,
                        ),
                      )
                    : controller.myRidesModel.value.data!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: SvgPicture.asset(ImageConstant.svgNoRides)),
                              Text(
                                "You have posted no rides",
                                style: TextStyleUtil.k24Heading600(),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              // Obx(
                              //   () => controller.myRidesModel.value.data![0]?.driverId == ''
                              //       ? const SizedBox()
                              //       : GestureDetector(
                              //           onTap: () => Get.to(() => const RideRequests()),
                              //           child: Container(
                              //             padding: EdgeInsets.all(16.kh),
                              //             decoration: BoxDecoration(
                              //               color: ColorUtil.kWhiteColor,
                              //               borderRadius: BorderRadius.circular(8.kh),
                              //               border: Border(
                              //                   bottom: BorderSide(
                              //                       color: ColorUtil.kNeutral7,
                              //                       width: 1.kh)),
                              //             ),
                              //             child: Row(
                              //               children: [
                              //                 SvgPicture.asset(
                              //                   ImageConstant.svgProfileSettings,
                              //                   colorFilter: ColorFilter.mode(
                              //                       Get.find<ProfileController>()
                              //                               .isSwitched
                              //                               .value
                              //                           ? ColorUtil.kPrimary3PinkMode
                              //                           : ColorUtil.kPrimary01,
                              //                       BlendMode.srcIn),
                              //                 ).paddingOnly(right: 12.kw),
                              //                 Text(
                              //                   'View ride requests',
                              //                   style: TextStyleUtil.k14Semibold(),
                              //                 ),
                              //                 const Expanded(child: SizedBox()),
                              //                 SvgPicture.asset(
                              //                     ImageConstant.svgIconRightArrow),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              // ),
                              Obx(
                                () => Expanded(
                                  child: ListView.builder(
                                    itemCount: controller.myRidesModel.value.data?.length,
                                    itemBuilder: (context, index) {
                                      if (controller.myRidesModel.value.data![index]?.driverId != null) {
                                        return GestureDetector(
                                          // check whether ride is cancelled
                                          onTap: controller.myRidesModel.value.data?[index]?.isCancelled == true
                                              ? () {}
                                              : () {
                                                  controller.viewDetails(controller.myRidesModel.value.data![index]!);
                                                },
                                          child: Container(
                                            padding: EdgeInsets.all(16.kh),
                                            decoration: BoxDecoration(
                                                color: ColorUtil.kWhiteColor,
                                                borderRadius: BorderRadius.circular(8.kh),
                                                border: Border(bottom: BorderSide(color: ColorUtil.kNeutral7, width: 2.kh))),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    controller.myRidesModel.value.data![index]?.time == ""
                                                        ? Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                ImageConstant.svgIconCalendarTime,
                                                                colorFilter: ColorFilter.mode(
                                                                    Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                    BlendMode.srcIn),
                                                              ).paddingOnly(right: 4.kw),
                                                              Text(
                                                                // '07 November 2023',
                                                                controller.myRidesModel.value.data![index]?.date?.split('T')[0] ?? "DD/MM/YYYY",
                                                                style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                                              ),
                                                            ],
                                                          ).paddingOnly(bottom: 8.kh)
                                                        : Text(
                                                            // '10:30 am',
                                                            "${controller.myRidesModel.value.data![index]?.time}",
                                                            style: TextStyleUtil.k16Bold(),
                                                          ),
                                                    SizedBox(
                                                      height: 24.kh,
                                                      width: 28.w,
                                                      child: ListView.builder(
                                                        itemCount: controller.myRidesModel.value.data![index]?.riders?.length == 0
                                                            ? 4
                                                            : controller.myRidesModel.value.data![index]?.riders?.length,
                                                        reverse: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index1) {
                                                          return Container(
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                            ),
                                                            child: ClipOval(
                                                              child: SizedBox.fromSize(
                                                                size: Size.fromRadius(12.kh),
                                                                child: controller.myRidesModel.value.data![index]?.riders?.length == 0
                                                                    ? Image.asset(
                                                                        ImageConstant.pngEmptyPassenger,
                                                                      )
                                                                    : Image(
                                                                        image: NetworkImage("${controller.myRidesModel.value.data![index]?.riders?[index1]?.profilePic?.url}"),
                                                                      ),
                                                              ),
                                                            ),
                                                          ).paddingOnly(right: 4.kw);
                                                        },
                                                      ),
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Container(
                                                    //       decoration:
                                                    //           const BoxDecoration(
                                                    //               shape: BoxShape
                                                    //                   .circle,
                                                    //               color: ColorUtil
                                                    //                   .kPrimary01),
                                                    //       child: ClipOval(
                                                    //         child: SizedBox
                                                    //             .fromSize(
                                                    //           size: Size
                                                    //               .fromRadius(
                                                    //                   12.kh),
                                                    //           child:
                                                    //               Image.asset(
                                                    //             ImageConstant
                                                    //                 .pngPassenger1,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ).paddingOnly(
                                                    //         right: 4.kw),
                                                    //     Container(
                                                    //       decoration:
                                                    //           const BoxDecoration(
                                                    //               shape: BoxShape
                                                    //                   .circle,
                                                    //               color: ColorUtil
                                                    //                   .kPrimary01),
                                                    //       child: ClipOval(
                                                    //         child: SizedBox
                                                    //             .fromSize(
                                                    //           size: Size
                                                    //               .fromRadius(
                                                    //                   12.kh),
                                                    //           child:
                                                    //               Image.asset(
                                                    //             ImageConstant
                                                    //                 .pngPassenger2,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ).paddingOnly(
                                                    //         right: 4.kw),
                                                    //     Container(
                                                    //       decoration:
                                                    //           const BoxDecoration(
                                                    //               shape: BoxShape
                                                    //                   .circle,
                                                    //               color: ColorUtil
                                                    //                   .kPrimary01),
                                                    //       child: ClipOval(
                                                    //         child: SizedBox
                                                    //             .fromSize(
                                                    //           size: Size
                                                    //               .fromRadius(
                                                    //                   12.kh),
                                                    //           child:
                                                    //               Image.asset(
                                                    //             ImageConstant
                                                    //                 .pngPassenger3,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ).paddingOnly(
                                                    //         right: 4.kw),
                                                    //     Container(
                                                    //       decoration:
                                                    //           const BoxDecoration(
                                                    //               shape: BoxShape
                                                    //                   .circle,
                                                    //               color: ColorUtil
                                                    //                   .kPrimary01),
                                                    //       child: ClipOval(
                                                    //         child: SizedBox
                                                    //             .fromSize(
                                                    //           size: Size
                                                    //               .fromRadius(
                                                    //                   12.kh),
                                                    //           child:
                                                    //               Image.asset(
                                                    //             ImageConstant
                                                    //                 .pngPassenger4,
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                controller.myRidesModel.value.data![index]?.time == ""
                                                    ? const SizedBox()
                                                    : Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            ImageConstant.svgIconCalendarTime,
                                                            colorFilter: ColorFilter.mode(
                                                                Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                BlendMode.srcIn),
                                                          ).paddingOnly(right: 4.kw),
                                                          Text(
                                                            // '07 November 2023',
                                                            controller.myRidesModel.value.data![index]?.date?.split('T')[0] ?? "DD/MM/YYYY",
                                                            style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                                          ),
                                                        ],
                                                      ).paddingOnly(bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 10.kh,
                                                          width: 10.kw,
                                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kGreenColor),
                                                        ).paddingOnly(right: 8.kw),
                                                        Expanded(
                                                          child: Text(
                                                            // '1100 McIntosh St, Regina',
                                                            controller.myRidesModel.value.data![index]?.origin?.name ?? 'Origin',
                                                            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ).paddingOnly(bottom: 30.kh),
                                                    Positioned(
                                                      top: 27.kh,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 10.kh,
                                                            width: 10.kw,
                                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kError4),
                                                          ).paddingOnly(right: 8.kw),
                                                          Text(
                                                            // '681 Chrislea Rd, Woodbridge',
                                                            controller.myRidesModel.value.data![index]?.destination?.name ?? 'Destination',
                                                            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 10.kh,
                                                      left: 4.5.kw,
                                                      child: Container(
                                                        height: 28.kh,
                                                        width: 1.kw,
                                                        color: ColorUtil.kBlack04,
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                Container(
                                                  width: 100.w,
                                                  height: 1.kh,
                                                  color: ColorUtil.kBlack07,
                                                ).paddingOnly(bottom: 16.kh),
                                                Obx(
                                                  () => controller.myRidesModel.value.data?[index]?.isCancelled == true
                                                      ? Text(
                                                          "Ride is cancelled",
                                                          style: TextStyleUtil.k16Bold(color: ColorUtil.kError2),
                                                        )
                                                      : isToday(controller.myRidesModel.value.data?[index]?.date ?? "")
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                GreenPoolButton(
                                                                    onPressed: () {
                                                                      Get.toNamed(Routes.START_RIDE, arguments: controller.myRidesModel.value.data?[index]);
                                                                    },
                                                                    width: 144.kw,
                                                                    height: 40.kh,
                                                                    padding: EdgeInsets.all(8.kh),
                                                                    fontSize: 14.kh,
                                                                    label: 'Start Ride'),
                                                                GreenPoolButton(
                                                                  onPressed: () {
                                                                    controller.cancelRideAPI(controller.myRidesModel.value.data![index]!);
                                                                  },
                                                                  width: 144.kw,
                                                                  height: 40.kh,
                                                                  padding: EdgeInsets.all(8.kh),
                                                                  fontSize: 14.kh,
                                                                  isBorder: true,
                                                                  borderColor:
                                                                      Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                  labelColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                  label: 'Cancel Ride',
                                                                ),
                                                              ],
                                                            )
                                                          : Align(
                                                              alignment: Alignment.topRight,
                                                              child: GreenPoolButton(
                                                                onPressed: () {
                                                                  controller.viewDetails(controller.myRidesModel.value.data![index]!);
                                                                },
                                                                width: 144.kw,
                                                                height: 40.kh,
                                                                padding: EdgeInsets.all(8.kh),
                                                                fontSize: 14.kh,
                                                                isBorder: true,
                                                                borderColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                labelColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                label: "View details",
                                                              ),
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ).paddingOnly(bottom: 16.kh),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: controller.myRidesModel.value.data?[index]!.rideStatus == "Confirmed"
                                              ? () {
                                                  Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS);
                                                }
                                              : () {
                                                  Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST, arguments: controller.myRidesModel.value.data?[index]?.Id);
                                                },
                                          child: Container(
                                            padding: EdgeInsets.all(16.kh),
                                            decoration: BoxDecoration(
                                              color: ColorUtil.kWhiteColor,
                                              borderRadius: BorderRadius.circular(8.kh),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                controller.myRidesModel.value.data?[index]!.rideStatus == "Confirmed"
                                                    ? Row(
                                                        children: [
                                                          //for profile pic and rating
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 64.kh,
                                                                width: 64.kw,
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                ),
                                                                child: Image.asset(
                                                                  ImageConstant.pngIconProfilePic,
                                                                ),
                                                              ).paddingOnly(bottom: 8.kh),
                                                              Positioned(
                                                                top: 52.kh,
                                                                left: 8.kw,
                                                                child: Container(
                                                                  width: 48.kw,
                                                                  height: 20.kh,
                                                                  padding: EdgeInsets.symmetric(horizontal: 8.kw),
                                                                  decoration: BoxDecoration(
                                                                      color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                      borderRadius: BorderRadius.circular(16.kh)),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.star,
                                                                        color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kWhiteColor : ColorUtil.kYellowColor,
                                                                        size: 12.kh,
                                                                      ).paddingOnly(right: 2.kw),
                                                                      Text(
                                                                        '4.5',
                                                                        style: TextStyleUtil.k12Semibold(
                                                                            color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kBlack02 : ColorUtil.kWhiteColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ).paddingOnly(right: 16.kw, bottom: 16.kh),
                                                          //for name and date
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Savannah Nguyen',
                                                                      style: TextStyleUtil.k16Bold(),
                                                                    ),
                                                                    Text.rich(
                                                                      TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text: 'Fare: ',
                                                                            style: TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                                                                          ),
                                                                          TextSpan(
                                                                            text: '\$ ${controller.myRidesModel.value.data?[index]?.fair}',
                                                                            style: TextStyleUtil.k16Semibold(fontSize: 16.kh, color: ColorUtil.kSecondary01),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ).paddingOnly(bottom: 8.kh),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SvgPicture.asset(
                                                                          ImageConstant.svgIconCalendarTime,
                                                                          colorFilter: ColorFilter.mode(
                                                                              Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                              BlendMode.srcIn),
                                                                        ).paddingOnly(right: 4.kw),
                                                                        Text(
                                                                          // '07 Nov 2023, 3:00pm',
                                                                          '${controller.myRidesModel.value.data?[index]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModel.value.data?[index]?.time ?? " "}',
                                                                          style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.time_to_leave,
                                                                          size: 18.kh,
                                                                          color:
                                                                              Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                        ).paddingOnly(right: 8.kw),
                                                                        Text(
                                                                          '${controller.myRidesModel.value.data?[index]?.seatAvailable} seats',
                                                                          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
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
                                                controller.myRidesModel.value.data?[index]!.rideStatus != "Confirmed"
                                                    ? Row(
                                                        children: [
                                                          controller.myRidesModel.value.data?[index]?.date == null
                                                              ? const SizedBox()
                                                              : SvgPicture.asset(
                                                                  ImageConstant.svgIconCalendarTime,
                                                                  colorFilter: ColorFilter.mode(
                                                                      Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                                      BlendMode.srcIn),
                                                                ).paddingOnly(right: 4.kw),
                                                          controller.myRidesModel.value.data?[index]?.date == null
                                                              ? const SizedBox()
                                                              : Text(
                                                                  // '07 Nov 2023, 3:00pm',
                                                                  '${controller.myRidesModel.value.data?[index]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModel.value.data?[index]?.time ?? " "}',
                                                                  style: TextStyleUtil.k16Bold(),
                                                                ),
                                                        ],
                                                      ).paddingOnly(bottom: 16.kh)
                                                    : const SizedBox(),
                                                //middle divider
                                                controller.myRidesModel.value.data?[index]?.date == null ? const SizedBox() : const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                                                Stack(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 10.kh,
                                                          width: 10.kw,
                                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kGreenColor),
                                                        ).paddingOnly(right: 8.kw),
                                                        Text(
                                                          // '1100 McIntosh St, Regina',
                                                          "${controller.myRidesModel.value.data?[index]?.origin?.name}",
                                                          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                                                        ),
                                                      ],
                                                    ).paddingOnly(bottom: 30.kh),
                                                    Positioned(
                                                      top: 27.kh,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 10.kh,
                                                            width: 10.kw,
                                                            decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorUtil.kError4),
                                                          ).paddingOnly(right: 8.kw),
                                                          Text(
                                                            // '681 Chrislea Rd, Woodbridge',
                                                            "${controller.myRidesModel.value.data?[index]?.destination?.name}",
                                                            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    //line joining red and green dots
                                                    Positioned(
                                                      top: 10.kh,
                                                      left: 4.5.kw,
                                                      child: Container(
                                                        height: 28.kh,
                                                        width: 1.kw,
                                                        color: ColorUtil.kBlack04,
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(bottom: 8.kh),
                                                //bottom line
                                                const GreenPoolDivider(),
                                                // rides matching your request
                                                controller.myRidesModel.value.data?[index]!.rideStatus != "Confirmed"
                                                    ? Container(
                                                        width: 100.w,
                                                        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.kw, vertical: 8.kh),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.kh), color: ColorUtil.kSecondary01),
                                                        child: Text(
                                                          "0 rides matching your request.",
                                                          style: TextStyleUtil.k14Semibold(color: ColorUtil.kWhiteColor),
                                                        ),
                                                      )
                                                    : Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          GreenPoolButton(
                                                            height: 40.kh,
                                                            width: 144.kw,
                                                            padding: EdgeInsets.all(0.kh),
                                                            onPressed: () {
                                                              controller.viewDetails(controller.myRidesModel.value.data![index]!);
                                                            },
                                                            label: 'View Details',
                                                            fontSize: 14.kh,
                                                            borderColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                            labelColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                          ),
                                                          GreenPoolButton(
                                                            height: 40.kh,
                                                            width: 144.kw,
                                                            padding: EdgeInsets.all(0.kh),
                                                            onPressed: () => controller.cancelRideAPI(controller.myRidesModel.value.data![index]!),
                                                            isBorder: true,
                                                            label: 'Cancel Ride',
                                                            fontSize: 14.kh,
                                                            borderColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                                            labelColor: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
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
    return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day;
  }
}

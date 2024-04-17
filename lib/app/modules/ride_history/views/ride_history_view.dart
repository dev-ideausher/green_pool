import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../services/colors.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/ride_history_controller.dart';

class RideHistoryView extends GetView<RideHistoryController> {
  const RideHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Ride History'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: Get.find<ProfileController>().isSwitched.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kPrimary01,
                ),
              )
            : controller.rideHistModel.value.data!.isEmpty
                ? Center(
                    child: Text(
                      "No ride history from past 7 days",
                      style: TextStyleUtil.k18Heading600(),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount:
                                controller.rideHistModel.value.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.RIDE_DETAILS,
                                      arguments: controller
                                          .rideHistModel.value.data?[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.kh),
                                  decoration: BoxDecoration(
                                    color: ColorUtil.kWhiteColor,
                                    borderRadius: BorderRadius.circular(8.kh),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          //for profile pic and rating
                                          Stack(
                                            children: [
                                              Container(
                                                      height: 64.kh,
                                                      width: 64.kw,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image(
                                                          image: NetworkImage(
                                                              "${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.driverDetails?[0]?.profilePic?.url}")))
                                                  .paddingOnly(bottom: 8.kh),
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
                                                                  ProfileController>()
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
                                                        Icons.star,
                                                        color: Get.find<
                                                                    ProfileController>()
                                                                .isSwitched
                                                                .value
                                                            ? ColorUtil
                                                                .kWhiteColor
                                                            : ColorUtil
                                                                .kYellowColor,
                                                        size: 12.kh,
                                                      ).paddingOnly(
                                                          right: 2.kw),
                                                      Text(
                                                        '${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.driverDetails?[0]?.rating?.toStringAsFixed(1)}',
                                                        style: TextStyleUtil.k12Semibold(
                                                            color: Get.find<
                                                                        ProfileController>()
                                                                    .isSwitched
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
                                              right: 16.kw, bottom: 8.kh),
                                          //for name and date
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.driverDetails?[0]?.fullName}',
                                                style: TextStyleUtil.k16Bold(),
                                              ).paddingOnly(bottom: 8.kh),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    ImageConstant
                                                        .svgIconCalendarTime,
                                                    colorFilter: ColorFilter.mode(
                                                        Get.find<ProfileController>()
                                                                .isSwitched
                                                                .value
                                                            ? ColorUtil
                                                                .kPrimary3PinkMode
                                                            : ColorUtil
                                                                .kSecondary01,
                                                        BlendMode.srcIn),
                                                  ).paddingOnly(right: 4.kw),
                                                  Text(
                                                    // '07 November 2023, 3:00pm',
                                                    "${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.date.toString().split("T").first ?? ""}  ${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.time ?? ""}",
                                                    style: TextStyleUtil
                                                        .k12Regular(
                                                            color: ColorUtil
                                                                .kBlack03),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      //middle divider
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
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorUtil.kGreenColor),
                                              ).paddingOnly(right: 8.kw),
                                              Text(
                                                '${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.origin?.name}',
                                                style: TextStyleUtil.k14Regular(
                                                    color: ColorUtil.kBlack02),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: ColorUtil
                                                              .kError4),
                                                ).paddingOnly(right: 8.kw),
                                                Text(
                                                  '${controller.rideHistModel.value.data?[index]?.driverBookingDetails?[0]?.destination?.name}',
                                                  style:
                                                      TextStyleUtil.k14Regular(
                                                          color: ColorUtil
                                                              .kBlack02),
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
                                      Container(
                                        width: 100.w,
                                        height: 1.kh,
                                        color: ColorUtil.kBlack07,
                                      ),
                                    ],
                                  ),
                                ).paddingOnly(bottom: 16.kh),
                              );
                            }).paddingOnly(top: 32.kh),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

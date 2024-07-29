import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/ride_history_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/ride_history_controller.dart';

class RideHistoryView extends GetView<RideHistoryController> {
  const RideHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.rideHistory),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
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
                              final his =
                                  controller.rideHistModel.value.data?[index];
                              print(
                                  Get.find<GetStorageService>().getFirebaseUid);
                              return ((his?.driver?.firebaseUid ?? "") ==
                                      Get.find<GetStorageService>()
                                          .getFirebaseUid)
                                  ? DriverRideHistTile(
                                      controller: controller,
                                      his: his,
                                      index: index,
                                    )
                                  : RiderRideHistTile(
                                      controller: controller,
                                      his: his,
                                      index: index);
                            }).paddingOnly(top: 8.kh),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

class RiderRideHistTile extends StatelessWidget {
  const RiderRideHistTile({
    super.key,
    required this.controller,
    required this.his,
    required this.index,
  });

  final RideHistoryController controller;
  final RideHistoryModelData? his;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.RIDE_DETAILS,
            arguments: controller.rideHistModel.value.data?[index]);
      },
      child: Container(
        padding: EdgeInsets.all(16.kh),
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
            border: Border.all(color: ColorUtil.kNeutral10, width: 0.3.kh)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: his?.rideStatus != "NA",
              child: Row(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.kh),
                          child: CommonImageView(
                            url: "${his?.driver?.profilePic?.url}",
                          ),
                        ),
                      ).paddingOnly(bottom: 8.kh),
                      Positioned(
                        top: 52.kh,
                        left: 8.kw,
                        child: Container(
                          width: 50.kw,
                          height: 20.kh,
                          padding: EdgeInsets.symmetric(horizontal: 8.kw),
                          decoration: BoxDecoration(
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                              borderRadius: BorderRadius.circular(16.kh)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Get.find<HomeController>()
                                        .isPinkModeOn
                                        .value
                                    ? ColorUtil.kWhiteColor
                                    : ColorUtil.kYellowColor,
                                size: 12.kh,
                              ).paddingOnly(right: 2.kw),
                              Text(
                                '${his?.driver?.rating?.toStringAsFixed(1) ?? "0"}',
                                style: TextStyleUtil.k12Semibold(
                                    color: Get.find<HomeController>()
                                            .isPinkModeOn
                                            .value
                                        ? ColorUtil.kBlack02
                                        : ColorUtil.kWhiteColor),
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
                              '${his?.driver?.fullName}',
                              style: TextStyleUtil.k16Bold(),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Fare: ',
                                    style: TextStyleUtil.k14Semibold(
                                        color: ColorUtil.kSecondary01),
                                  ),
                                  TextSpan(
                                    text: '\$ ${his?.price}',
                                    style: TextStyleUtil.k16Semibold(
                                        fontSize: 16.kh,
                                        color: ColorUtil.kSecondary01),
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
                                      Get.find<HomeController>()
                                              .isPinkModeOn
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      BlendMode.srcIn),
                                ).paddingOnly(right: 4.kw),
                                Text(
                                  // '07 Nov 2023, 3:00pm',
                                  "${GpUtil.getDateFormat(his?.time ?? "")} ${GpUtil.convertUtcToLocal(his?.time ?? "")}",
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack03),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.time_to_leave,
                                  size: 18.kh,
                                  color: Get.find<HomeController>()
                                          .isPinkModeOn
                                          .value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  '${his?.seatAvailable} seats',
                                  style: TextStyleUtil.k14Regular(
                                      color: ColorUtil.kBlack03),
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
            ),

            Visibility(
                visible: his?.rideStatus == "NA",
                child: Row(
                  children: [
                    his?.date == null
                        ? const SizedBox()
                        : SvgPicture.asset(
                            ImageConstant.svgIconCalendarTime,
                            colorFilter: ColorFilter.mode(
                                Get.find<HomeController>().isPinkModeOn.value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ).paddingOnly(right: 4.kw),
                    his?.date == null
                        ? const SizedBox()
                        : Text(
                            // '07 Nov 2023, 3:00pm',
                            '${GpUtil.getDateFormat(his?.time ?? "")}  ${GpUtil.convertUtcToLocal(his?.time ?? "")}',
                            style: TextStyleUtil.k16Bold(),
                          ),
                  ],
                ).paddingOnly(bottom: 16.kh)),

            //middle divider
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
            OriginToDestination(
                    needPickupText: false,
                    origin: "${his?.origin?.name}",
                    stop1: his?.stops?[0]?.name ?? "",
                    stop2: his?.stops?[1]?.name ?? "",
                    destination: "${his?.destination?.name}")
                .paddingOnly(bottom: 8.kh),
            const GreenPoolDivider(),
            Visibility(
                visible:
                    controller.rideHistModel.value.data?[index]?.rideStatus ==
                        "Cancel",
                child: Container(
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorUtil.kNeutral1,
                      borderRadius: BorderRadius.circular(8.kh)),
                  padding:
                      EdgeInsets.symmetric(vertical: 4.kh, horizontal: 24.kw),
                  child: Text(
                    "Cancelled Ride",
                    style: TextStyleUtil.k14Semibold(color: ColorUtil.kError2),
                  ),
                ).paddingOnly(top: 8.kh))
          ],
        ),
      ).paddingOnly(bottom: 16.kh),
    );
  }
}

class DriverRideHistTile extends StatelessWidget {
  const DriverRideHistTile({
    super.key,
    required this.controller,
    required this.his,
    required this.index,
  });

  final RideHistoryController controller;
  final RideHistoryModelData? his;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.RIDE_DETAILS,
            arguments: controller.rideHistModel.value.data?[index]);
      },
      child: Container(
        padding: EdgeInsets.all(16.kh),
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
            border: Border.all(width: 0.3.kh, color: ColorUtil.kNeutral10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SizedBox(
                  height: 40.kh,
                  width: 40.kw,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.kh),
                      child: CommonImageView(
                          url: Get.find<HomeController>()
                              .userInfo
                              .value
                              .data
                              ?.profilePic
                              ?.url))),
              title: Text(
                  Get.find<HomeController>().userInfo.value.data?.fullName ??
                      "",
                  style: TextStyleUtil.k16Bold()),
              subtitle: Text(
                // GpUtil.getDateFormat(controller.rideHistModel.value.data?[index]?.date) ??
                ((controller.rideHistModel.value.data?[index]?.time ?? "") == ""
                    ? ""
                    : GpUtil.convertUtcToLocal(
                        controller.rideHistModel.value.data?[index]?.time ??
                            "")),
                style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
              ),
              trailing: SizedBox(
                height: 24.kh,
                width: 150.kw,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (controller.rideHistModel.value.data?[index]
                                    ?.riders?.length ??
                                0) ==
                            0
                        ? 4
                        : controller
                            .rideHistModel.value.data?[index]?.riders?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index1) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(12.kh),
                            child: (controller.rideHistModel.value.data?[index]
                                            ?.riders?.length ??
                                        0) ==
                                    0
                                ? Image.asset(
                                    ImageConstant.pngEmptyPassenger,
                                  )
                                : CommonImageView(
                                    url:
                                        "${controller.rideHistModel.value.data?[index]?.riders?[index1]?.profilePic?.url}"),
                          ),
                        ),
                      ).paddingOnly(right: 4.kw);
                    },
                  ),
                ),
              ),
            ),
            // Text(controller.rideHistModel.value.data?[index]?.origin?.originDestinationFair??"0", style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03)),

            12.kheightBox,
            //-------------------- if rider has done "Find a Ride" and has not selected any time ----------------

            controller.rideHistModel.value.data?[index]?.time == ""
                ? const SizedBox()
                : Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstant.svgIconCalendarTime,
                        colorFilter: ColorFilter.mode(
                            Get.find<HomeController>().isPinkModeOn.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                            BlendMode.srcIn),
                      ).paddingOnly(right: 4.kw),
                      Text(
                        GpUtil.getDateFormat(
                            controller.rideHistModel.value.data?[index]?.time ??
                                ""),
                        style:
                            TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                      ),
                    ],
                  ).paddingOnly(bottom: 8.kh),
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
            OriginToDestination(
              needPickupText: false,
              origin:
                  controller.rideHistModel.value.data?[index]?.origin?.name ??
                      Strings.pickup,
              stop1: controller
                      .rideHistModel.value.data?[index]?.stops?[0]?.name ??
                  "",
              stop2: controller
                      .rideHistModel.value.data?[index]?.stops?[1]?.name ??
                  "",
              destination: controller
                      .rideHistModel.value.data?[index]?.destination?.name ??
                  Strings.destination,
            ).paddingOnly(bottom: 8.kh),
            const GreenPoolDivider().paddingOnly(bottom: 16.kh),
            Visibility(
                visible:
                    controller.rideHistModel.value.data?[index]?.rideStatus ==
                        "Cancel",
                child: Container(
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorUtil.kNeutral1,
                      borderRadius: BorderRadius.circular(8.kh)),
                  padding:
                      EdgeInsets.symmetric(vertical: 4.kh, horizontal: 24.kw),
                  child: Text(
                    "Cancelled Ride",
                    style: TextStyleUtil.k14Semibold(color: ColorUtil.kError2),
                  ),
                ))
          ],
        ),
      ).paddingOnly(bottom: 16.kh),
    );
  }
}

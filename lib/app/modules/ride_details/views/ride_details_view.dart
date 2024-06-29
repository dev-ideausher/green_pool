//! ride details after ride history in profile
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/ride_details_controller.dart';

class RideDetailsView extends GetView<RideDetailsController> {
  const RideDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isRideCancelled = controller.rideHistory.value.rideStatus == "Cancel";
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.rideDetails),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //ride completed
          Container(
            padding: EdgeInsets.all(16.kh),
            decoration: BoxDecoration(
                color:
                    isRideCancelled ? ColorUtil.kError2 : ColorUtil.kGreenColor,
                borderRadius: BorderRadius.circular(8.kh)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  isRideCancelled ? Icons.block : Icons.check,
                  size: 20.kh,
                  color: ColorUtil.kWhiteColor,
                ).paddingOnly(right: 8.kw),
                Text(
                  isRideCancelled ? "Ride Cancelled" : 'Completed Successfully',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kWhiteColor),
                ),
              ],
            ),
          ).paddingOnly(top: 32.kh, bottom: 16.kh),

          //details with pick up and drop off
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                            url:
                                "${controller.rideHistory.value.driver?.profilePic?.url}",
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
                                '${controller.rideHistory.value.driver?.rating!.toStringAsFixed(1)}',
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
                              '${controller.rideHistory.value.driver?.fullName}',
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
                                    text:
                                        '\$ ${controller.rideHistory.value.origin?.originDestinationFair}',
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
                                  "${GpUtil.getDateFormat(controller.rideHistory.value.date)} ${controller.rideHistory.value.time ?? ""}",
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
                                  // '${controller.rideHistory.value.driver?.} seats',
                                  'seats',
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
              //middle divider
              const GreenPoolDivider().paddingOnly(bottom: 16.kh),
              OriginToDestination(
                      origin: '${controller.rideHistory.value.origin?.name}',
                      destination:
                          '${controller.rideHistory.value.destination?.name}',
                      needPickupText: true)
                  .paddingOnly(bottom: 8.kh),
              //bottom line
              const GreenPoolDivider(),
            ],
          ).paddingOnly(bottom: 16.kh),

          //co passengers
          Text(
            Strings.coPassengers,
            style: TextStyleUtil.k14Bold(),
          ).paddingOnly(bottom: 16.kh),
          SizedBox(
            height: 96.kh,
            child: controller.rideHistory.value.riders?.length == 0
                ? Center(
                    child: Text(
                      Strings.noPassengersAvailable,
                      style: TextStyleUtil.k14Semibold(),
                    ),
                  ).paddingOnly(bottom: 16.kh)
                : ListView.builder(
                    itemCount: controller.rideHistory.value.riders?.length ?? 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                                child: SizedBox.fromSize(
                                    size: Size.fromRadius(20.kh),
                                    child: CommonImageView(
                                        url:
                                            "${controller.rideHistory.value.riders?[index]?.profilePic?.url}"))),
                          ).paddingOnly(bottom: 4.kh),
                          Text(
                            "${controller.rideHistory.value.riders?[index]?.fullName.toString().split(" ").first}\n${controller.rideHistory.value.riders?[index]?.fullName.toString().split(" ").last}",
                            style: TextStyleUtil.k12Semibold(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).paddingOnly(right: 32.kw);
                    }),
          ).paddingOnly(bottom: 16.kh),
          const GreenPoolDivider().paddingOnly(bottom: 16.kh),

          //Vehicle details
          Text(
            Strings.vehicleDetails,
            style: TextStyleUtil.k14Bold(),
          ).paddingOnly(bottom: 16.kh),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.kh),
                child: CommonImageView(
                    height: 64.kh,
                    width: 64.kw,
                    url:
                        "${controller.rideHistory.value.driverVehicle?.vehiclePic?.url}"),
              ).paddingOnly(right: 8.kh),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.rideHistory.value.driverVehicle?.model}',
                    style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                  ).paddingOnly(bottom: 4.kh),
                  Row(
                    children: [
                      Text(
                        '${controller.rideHistory.value.driverVehicle?.type}',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack03),
                      ),
                      Container(
                        width: 1.kw,
                        height: 16.kh,
                        color: ColorUtil.kBlack03,
                      ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                      Text(
                        '${controller.rideHistory.value.driverVehicle?.licencePlate}',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack03),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),

          //Bill details
          Text(
            'Bill Details',
            style: TextStyleUtil.k14Bold(),
          ).paddingOnly(bottom: 16.kh),
          //TODO: bill details
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

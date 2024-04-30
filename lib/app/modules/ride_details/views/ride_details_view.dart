//! ride details after ride history in profile
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../constants/image_constant.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/ride_details_controller.dart';
import 'copassenger_list.dart';

class RideDetailsView extends GetView<RideDetailsController> {
  const RideDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Ride Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //ride completed
          Container(
            padding: EdgeInsets.all(16.kh),
            decoration: BoxDecoration(
                color: Get.find<HomeController>().isSwitched.value
                    ? ColorUtil.kSecondaryPinkMode
                    : ColorUtil.kSecondary07,
                borderRadius: BorderRadius.circular(8.kh)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  size: 20.kh,
                  color: ColorUtil.kSecondary01,
                ).paddingOnly(right: 8.kw),
                Text(
                  'Completed Successfully',
                  style: TextStyleUtil.k14Regular(),
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
                              child: Image(
                                  image: NetworkImage(
                                      "${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.profilePic?.url}")))
                          .paddingOnly(bottom: 8.kh),
                      Positioned(
                        top: 52.kh,
                        left: 8.kw,
                        child: Container(
                          width: 48.kw,
                          height: 20.kh,
                          padding: EdgeInsets.symmetric(horizontal: 8.kw),
                          decoration: BoxDecoration(
                              color: Get.find<HomeController>().isSwitched.value
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              borderRadius: BorderRadius.circular(16.kh)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Get.find<HomeController>()
                                        .isSwitched
                                        .value
                                    ? ColorUtil.kWhiteColor
                                    : ColorUtil.kYellowColor,
                                size: 12.kh,
                              ).paddingOnly(right: 2.kw),
                              Text(
                                '${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.rating!.toStringAsFixed(1)}',
                                style: TextStyleUtil.k12Semibold(
                                    color: Get.find<HomeController>()
                                            .isSwitched
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
                              '${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.fullName}',
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
                                        '\$ ${controller.rideHistory.value.driverBookingDetails?[0]?.origin?.originDestinationFair}',
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
                                              .isSwitched
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      BlendMode.srcIn),
                                ).paddingOnly(right: 4.kw),
                                //might give problems with big names, have to cut short month names
                                Text(
                                  // '07 Nov 2023, 3:00pm',
                                  "${controller.rideHistory.value.driverBookingDetails?[0]?.date.toString().split("T").first ?? ""}  ${controller.rideHistory.value.driverBookingDetails?[0]?.time ?? ""}",
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
                                          .isSwitched
                                          .value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  '${controller.rideHistory.value.driverBookingDetails?[0]?.seatAvailable} seats',
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
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.kh,
                        width: 10.kw,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtil.kGreenColor),
                      ).paddingOnly(right: 8.kw),
                      Text(
                        'Pick up: ',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack02),
                      ).paddingOnly(right: 8.kw),
                      Text(
                        '${controller.rideHistory.value.driverBookingDetails?[0]?.origin?.name}',
                        style:
                            TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
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
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: ColorUtil.kError4),
                        ).paddingOnly(right: 8.kw),
                        Text(
                          'Drop off: ',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack02),
                        ).paddingOnly(right: 8.kw),
                        Text(
                          '${controller.rideHistory.value.driverBookingDetails?[0]?.destination?.name}',
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack02),
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
            ],
          ).paddingOnly(bottom: 16.kh),

          //co passengers
          Text(
            'Co-Passengers',
            style: TextStyleUtil.k14Bold(),
          ).paddingOnly(bottom: 16.kh),
          SizedBox(
            height: 96.kh,
            child: controller.rideHistory.value.driverBookingDetails?[0]?.riders
                        ?.length ==
                    0
                ? const Center(
                    child: Text("No co-passengers are available at the moment"))
                : ListView.builder(
                    itemCount: controller.rideHistory.value
                            .driverBookingDetails?[0]?.riders?.length ??
                        6,
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
                                  child: Image(
                                      image: NetworkImage(
                                          "${controller.rideHistory.value.driverBookingDetails?[0]?.riders?[index]?.profilePic?.url}"))),
                            ),
                          ).paddingOnly(bottom: 4.kh),
                          Text(
                            "${controller.rideHistory.value.driverBookingDetails?[0]?.riders?[index]?.fullName.toString().split(" ").first}\n${controller.rideHistory.value.driverBookingDetails?[0]?.riders?[index]?.fullName.toString().split(" ").last}",
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
            'Vehicle Details',
            style: TextStyleUtil.k14Bold(),
          ).paddingOnly(bottom: 16.kh),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.kh),
                child: Image(
                  height: 64.kh,
                  width: 64.kw,
                  image: NetworkImage(
                      "${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.vechileDetails?[0]?.vehiclePic?.url}"),
                ).paddingOnly(right: 8.kh),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.vechileDetails?[0]?.model}',
                    style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                  ).paddingOnly(bottom: 4.kh),
                  Row(
                    children: [
                      Text(
                        '${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.vechileDetails?[0]?.type}',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack03),
                      ),
                      Container(
                        width: 1.kw,
                        height: 16.kh,
                        color: ColorUtil.kBlack03,
                      ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                      Text(
                        '${controller.rideHistory.value.driverBookingDetails?[0]?.driverDetails?[0]?.vechileDetails?[0]?.licencePlate}',
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

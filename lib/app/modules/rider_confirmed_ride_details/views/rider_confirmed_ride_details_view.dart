//! this page comes after tapping on confirmed rider tile in my_rides_view
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../post_ride_step_one/views/amenities.dart';
import '../controllers/rider_confirmed_ride_details_controller.dart';

class RiderConfirmedRideDetailsView
    extends GetView<RiderConfirmedRideDetailsController> {
  const RiderConfirmedRideDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.riderDetails),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //details with pick up and drop off
            Column(
              children: [
                Visibility(
                  visible: controller.myRidesModel.value.confirmDriverDetails
                          ?.first?.driverPostsDetails?.first?.isStarted ??
                      false,
                  child: Card(
                      margin: EdgeInsets.zero,
                      color: ColorUtil.kSecondary01,
                      child: ListTile(
                        onTap: () => controller.viewOnMap(),
                        leading: const Icon(Icons.access_time_rounded,
                            color: ColorUtil.kWhiteColor),
                        title: Text("Your ride is arriving in ${10} mins.",
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kWhiteColor)),
                        trailing: Container(
                            padding: EdgeInsets.all(4.kh),
                            decoration: BoxDecoration(
                                color: ColorUtil.kPrimary01,
                                borderRadius: BorderRadius.circular(100.kh)),
                            child: const Icon(Icons.pin_drop,
                                color: ColorUtil.kWhiteColor)),
                      )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.kh),
                        child: CommonImageView(
                          url:
                              "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url}",
                          height: 50.kh,
                          width: 50.kw,
                        ),
                      ),
                      title: Text(
                        "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName}",
                        style: TextStyleUtil.k16Bold(),
                      ),
                      subtitle: Row(
                        mainAxisSize: MainAxisSize.min,
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
                            "${GpUtil.getDateFormat(controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.time ?? "")}  ${GpUtil.convertUtcToLocal(controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.time ?? "")}",
                            style: TextStyleUtil.k12Regular(
                                color: ColorUtil.kBlack03),
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 120.kw,
                        child: Column(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: Strings.fare,
                                    style: TextStyleUtil.k14Semibold(
                                        color: ColorUtil.kSecondary01),
                                  ),
                                  TextSpan(
                                    text:
                                        '\$ ${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.origin?.originDestinationFair}',
                                    style: TextStyleUtil.k16Semibold(
                                        fontSize: 16.kh,
                                        color: ColorUtil.kSecondary01),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
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
                                  "${controller.myRidesModel.value.seatAvailable} seats",
                                  style: TextStyleUtil.k12Regular(
                                      color: ColorUtil.kBlack03),
                                ),
                              ],
                            )
                          ],
                        ).paddingOnly(top: 6.kh),
                      ),
                    ),

                    //middle divider
                    const GreenPoolDivider().paddingOnly(bottom: 8.kh),
                    OriginToDestination(
                            needPickupText: true,
                            origin:
                                "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.origin?.name}",
                            stop1: controller
                                    .myRidesModel
                                    .value
                                    .confirmDriverDetails?[0]
                                    ?.driverPostsDetails?[0]
                                    ?.stops?[0]
                                    ?.name ??
                                "",
                            stop2: controller
                                    .myRidesModel
                                    .value
                                    .confirmDriverDetails?[0]
                                    ?.driverPostsDetails?[0]
                                    ?.stops?[1]
                                    ?.name ??
                                "",
                            destination:
                                "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.destination?.name}")
                        .paddingOnly(bottom: 8.kh),
                    //bottom line
                    const GreenPoolDivider(),
                  ],
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //rating column
                  children: [
                    Text(
                      'Rating',
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.kw, vertical: 2.kh),
                      decoration: BoxDecoration(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                        borderRadius: BorderRadius.circular(16.kh),
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.star,
                          color: Get.find<HomeController>().isPinkModeOn.value
                              ? ColorUtil.kWhiteColor
                              : ColorUtil.kYellowColor,
                          size: 12.kh,
                        ).paddingOnly(right: 4.kw),
                        Text(
                          // "tot rating",
                          "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.rating}",
                          style: TextStyleUtil.k14Regular(),
                        ),
                      ]),
                    ),
                  ],
                ),
                Column(
                  //ride with column
                  children: [
                    Text(
                      'Ride With',
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      // "people ride with",
                      "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.totalRides}",
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
                Column(
                  //joined in column
                  children: [
                    Text(
                      'Joined',
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      'in ${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.createdAt.toString().split("-")[0]}',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(vertical: 8.kh),

            const GreenPoolDivider().paddingOnly(bottom: 16.kh),

            //co passengers
            Text(
              Strings.coPassengers,
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),
            (controller.myRidesModel.value.confirmDriverDetails?[0]
                            ?.driverPostsDetails?[0]?.ridersDetails!.length ??
                        0) ==
                    0
                ? Center(
                    child: Text(
                      Strings.noPassengersAvailable,
                      style: TextStyleUtil.k14Semibold(),
                    ),
                  ).paddingOnly(bottom: 16.kh)
                : SizedBox(
                    height: 96.kh,
                    child: ListView.builder(
                        itemCount: controller
                                .myRidesModel
                                .value
                                .confirmDriverDetails?[0]
                                ?.driverPostsDetails?[0]
                                ?.ridersDetails
                                ?.length ??
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
                                        child: CommonImageView(
                                            url:
                                                "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.ridersDetails?[index]?.profilePic?.url}"))),
                              ).paddingOnly(bottom: 4.kh),
                              Text(
                                "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.ridersDetails?[index]?.fullName.toString().split(" ").first}",
                                style: TextStyleUtil.k12Semibold(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ).paddingOnly(right: 32.kw);
                        }),
                  ).paddingOnly(bottom: 16.kh),
            const GreenPoolDivider().paddingOnly(bottom: 16.kh),

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
                          "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.vehicleDetails?[0]?.vehiclePic?.url}"),
                ).paddingOnly(right: 8.kh),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Toyota Corolla',
                      "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.vehicleDetails?[0]?.model}",
                      style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                    ).paddingOnly(bottom: 4.kh),
                    Row(
                      children: [
                        Text(
                          // 'Sedan',
                          "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.vehicleDetails?[0]?.type}",
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack03),
                        ),
                        Container(
                          width: 1.kw,
                          height: 16.kh,
                          color: ColorUtil.kBlack03,
                        ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                        Text(
                          "${controller.myRidesModel.value.confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.vehicleDetails?[0]?.licencePlate}",
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 16.kh),

            //Features available
            Text(
              'Features available',
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),

            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.AppreciatesConversation ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Appreciates Conversation",
                        image: ImageConstant.svgAmenities1)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.EnjoysMusic ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Enjoys Music",
                        image: ImageConstant.svgAmenities2)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.SmokeFree ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Smoke-Free",
                        image: ImageConstant.svgAmenities3)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.PetFriendly ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Pet-friendly",
                        image: ImageConstant.svgAmenities4)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.WinterTires ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Winter Tires",
                        image: ImageConstant.svgAmenities5)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.CoolingOrHeating ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Cooling or Heating",
                        image: ImageConstant.svgAmenities6)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.BabySeat ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Baby Seats",
                        image: ImageConstant.svgAmenities7)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller
                        .myRidesModel
                        .value
                        .confirmDriverDetails?[0]
                        ?.driverPostsDetails?[0]
                        ?.preferences
                        ?.other
                        ?.HeatedSeats ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: "Heated Seats",
                        image: ImageConstant.svgAmenities8)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),

            const GreenPoolDivider().paddingOnly(top: 8.kh),
            GreenPoolButton(
              onPressed: () {
                controller.openMessage(controller.myRidesModel.value);
              },
              label: Strings.message,
            ).paddingOnly(top: 40.kh, bottom: 16.kh),
            GreenPoolButton(
              onPressed: () async {
                await controller
                    .riderCancelRideAPI(controller.myRidesModel.value);
              },
              label: 'Cancel',
              isBorder: true,
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

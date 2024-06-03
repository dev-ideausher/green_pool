//! comes when tapped on confirm tiles after tapping on rider tiles in my_rides_view
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../post_ride/views/amenities.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import '../controllers/rider_my_rides_confirm_details_controller.dart';

class RiderMyRidesConfirmDetailsView extends GetView<RiderMyRidesConfirmDetailsController> {
  const RiderMyRidesConfirmDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Driver Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          height: 74.kh,
                          width: 74.kw,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.kh),
                              child: CommonImageView(
                                  url: "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.profilePic?.url}")),
                        ).paddingOnly(bottom: 8.kh),
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
                                // 'Sam Alexander',
                                "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.fullName}",
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
                                      text: '\$ ${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.origin?.originDestinationFair}',
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
                                    colorFilter:
                                        ColorFilter.mode(Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01, BlendMode.srcIn),
                                  ).paddingOnly(right: 4.kw),
                                  Text(
                                    // '07 Nov 2023, 3:00pm',
                                    "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.date.toString().split("T")[0]}  ${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.time}",
                                    style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.time_to_leave,
                                    size: 18.kh,
                                    color: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                                  ).paddingOnly(right: 8.kw),
                                  Text(
                                    "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.seatAvailable} seats",
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
                ).paddingOnly(top: 32.kh),
                //middle divider
                const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                OriginToDestination(
                        origin: "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.origin?.name}",
                        destination: "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.destination?.name}",
                        needPickupText: true)
                    .paddingOnly(bottom: 8.kh),
                //bottom line
                const GreenPoolDivider(),
              ],
            ).paddingOnly(bottom: 16.kh),

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
                      padding: EdgeInsets.symmetric(horizontal: 12.kw, vertical: 2.kh),
                      decoration: BoxDecoration(
                        color: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kPrimary01,
                        borderRadius: BorderRadius.circular(16.kh),
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.star,
                          color: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kWhiteColor : ColorUtil.kYellowColor,
                          size: 12.kh,
                        ).paddingOnly(right: 4.kw),
                        Text(
                          "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.rating?.roundToDouble()}",
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
                      "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.totalRides} people",
                      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
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
                      'in ${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.createdAt.toString().split("-")[0]}',
                      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(bottom: 8.kh),

            const GreenPoolDivider().paddingOnly(bottom: 16.kh),

            //co passengers
            Text(
              'Co-Passsengers',
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),
            Obx(
              () => controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.riders?.length == 0
                  ? Center(
                      child: Text(
                        "No co-passengers are available at the moment",
                        style: TextStyleUtil.k14Semibold(),
                      ),
                    )
                  : SizedBox(
                      height: 96.kh,
                      child: ListView.builder(
                          itemCount: controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.riders?.length ?? 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
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
                                                  "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.riders?[index1]?.profilePic?.url}"))),
                                ).paddingOnly(bottom: 4.kh),
                                Text(
                                  "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.riders?[index1]?.fullName}",
                                  style: TextStyleUtil.k12Semibold(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ).paddingOnly(right: 32.kw);
                          }),
                    ).paddingOnly(bottom: 10.kh),
            ),
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
                  child: CommonImageView(
                          height: 64.kh,
                          width: 64.kw,
                          url: "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.profilePic?.url}")
                      .paddingOnly(right: 8.kh),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.vehicleDetails?[0]?.model}",
                      style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                    ).paddingOnly(bottom: 4.kh),
                    Row(
                      children: [
                        Text(
                          "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.vehicleDetails?[0]?.type}",
                          style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack03),
                        ),
                        Container(
                          width: 1.kw,
                          height: 16.kh,
                          color: ColorUtil.kBlack03,
                        ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                        Text(
                          "${controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.driverDetails?[0]?.vehicleDetails?[0]?.licencePlate}",
                          style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack03),
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

            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.AppreciatesConversation == true
                ? Amenities(toggleSwitch: false, text: "Appreciates Conversation", image: ImageConstant.svgAmenities1).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.EnjoysMusic == true
                ? Amenities(toggleSwitch: false, text: "Enjoys Music", image: ImageConstant.svgAmenities2).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.SmokeFree == true
                ? Amenities(toggleSwitch: false, text: "Smoke-Free", image: ImageConstant.svgAmenities3).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.PetFriendly == true
                ? Amenities(toggleSwitch: false, text: "Pet-friendly", image: ImageConstant.svgAmenities4).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.WinterTires == true
                ? Amenities(toggleSwitch: false, text: "Winter Tires", image: ImageConstant.svgAmenities5).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.CoolingOrHeating == true
                ? Amenities(toggleSwitch: false, text: "Cooling or Heating", image: ImageConstant.svgAmenities6).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.BabySeat == true
                ? Amenities(toggleSwitch: false, text: "Baby Seats", image: ImageConstant.svgAmenities7).paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            (controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails?.preferences?.other?.HeatedSeats) == true
                ? Amenities(toggleSwitch: false, text: "Heated Seats", image: ImageConstant.svgAmenities8).paddingOnly(bottom: 8.kh)
                : const SizedBox(),

            const GreenPoolDivider().paddingOnly(top: 8.kh),
            GreenPoolButton(
              onPressed: () => Get.find<RiderMyRideRequestController>().openMessageFromConfirm(controller.riderConfirmRequestModel.value.data?[controller.index]?.driverRideDetails),
              label: Strings.message,
              isBorder: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GreenPoolButton(
                  onPressed: () async {
                    try {
                      await Get.find<RiderMyRideRequestController>().acceptDriversRequestAPI(controller.index);
                    } catch (e) {
                      throw Exception(e);
                    }
                  },
                  width: 162.kw,
                  label: 'Accept',
                ).paddingSymmetric(vertical: 40.kh),
                GreenPoolButton(
                  onPressed: () {},
                  width: 162.kw,
                  label: 'Reject',
                  isBorder: true,
                ).paddingSymmetric(vertical: 40.kh),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

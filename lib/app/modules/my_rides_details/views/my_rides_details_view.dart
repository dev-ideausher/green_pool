//! comes after tapping on the driver tile in My Rides
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/post_ride/views/amenities.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/my_rides_details_controller.dart';

class MyRidesDetailsView extends GetView<MyRidesDetailsController> {
  const MyRidesDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.rideDetails),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //details with pick up and drop off
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  // "7 July 2023, 3:00pm",

                                  "${controller.myRidesModelData.value.driverBookingDetails?.date.toString().split("T").first ?? ""}  ${controller.myRidesModelData.value.driverBookingDetails?.time ?? "00:00"}",
                                  style: TextStyleUtil.k16Bold(
                                      color: ColorUtil.kBlack02),
                                )
                              ],
                            ),
                            Text(
                              "${Strings.fare}\$ ${controller.myRidesModelData.value.driverBookingDetails?.origin?.originDestinationFair ?? ""}",
                              style: TextStyleUtil.k16Semibold(
                                  fontSize: 16.kh,
                                  color: ColorUtil.kSecondary01),
                            ),
                          ],
                        ),
                        const GreenPoolDivider()
                            .paddingSymmetric(vertical: 16.kh),
                        Text(
                          Strings.pickupToDrop,
                          style: TextStyleUtil.k16Bold(),
                        ).paddingOnly(bottom: 16.kh),
                        OriginToDestination(
                                origin: controller.myRidesModelData.value
                                        .driverBookingDetails?.origin?.name ??
                                    "",
                                destination: controller
                                        .myRidesModelData
                                        .value
                                        .driverBookingDetails
                                        ?.destination
                                        ?.name ??
                                    "",
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

                    (controller.myRidesModelData.value.driverBookingDetails
                                    ?.riders?.length ??
                                0) ==
                            0
                        ? Center(
                            child: Text(
                              Strings.noPassengersAvailable,
                              style: TextStyleUtil.k14Semibold(),
                            ),
                          ).paddingOnly(bottom: 16.kh)
                        : SizedBox(
                            height: ((controller
                                        .myRidesModelData
                                        .value
                                        .driverBookingDetails
                                        ?.riderBookingDetails
                                        ?.length ??
                                    0) *
                                122.kh),
                            child: ListView.builder(
                                itemCount: controller
                                        .myRidesModelData
                                        .value
                                        .driverBookingDetails
                                        ?.riderBookingDetails
                                        ?.length ??
                                    0,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index1) {
                                  final rider = controller
                                      .myRidesModelData
                                      .value
                                      .driverBookingDetails
                                      ?.riderBookingDetails?[index1];
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
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
                                                          "${rider?.riderDetails?.profilePic?.url ?? ""}"),
                                                ),
                                              ),
                                            ).paddingOnly(right: 8.kw),
                                            Text(
                                              rider?.riderDetails?.fullName ??
                                                  "",
                                              style:
                                                  TextStyleUtil.k14Semibold(),
                                            ),
                                          ],
                                        ).paddingOnly(bottom: 12.kh),
                                        OriginToDestination(
                                                needPickupText: true,
                                                origin:
                                                    '${controller.myRidesModelData.value?.driverBookingDetails?.origin?.name}',
                                                destination:
                                                    '${controller.myRidesModelData.value?.driverBookingDetails?.destination?.name}')
                                            .paddingOnly(bottom: 8.kh),
                                      ],
                                    ),
                                  );
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
                          child: SizedBox(
                            height: 64.kh,
                            width: 64.kw,
                            child: CommonImageView(
                                url: (controller
                                        .myRidesModelData
                                        .value
                                        .driverDetails
                                        ?.vehicleDetails
                                        ?.vehiclePic
                                        ?.url ??
                                    "")),
                          ),
                        ).paddingOnly(right: 8.kw),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.myRidesModelData.value?.driverDetails?.vehicleDetails?.model}',
                              style: TextStyleUtil.k16Bold(
                                  color: ColorUtil.kBlack02),
                            ).paddingOnly(bottom: 4.kh),
                            Row(
                              children: [
                                Text(
                                  '${controller.myRidesModelData.value?.driverDetails?.vehicleDetails?.type}',
                                  style: TextStyleUtil.k14Semibold(
                                      color: ColorUtil.kBlack03),
                                ),
                                Container(
                                  width: 1.kw,
                                  height: 16.kh,
                                  color: ColorUtil.kBlack03,
                                ).paddingSymmetric(
                                    vertical: 2.5.kh, horizontal: 8.kw),
                                Text(
                                  '${controller.myRidesModelData.value?.driverDetails?.vehicleDetails?.licencePlate}',
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

                    //Features available
                    Text(
                      Strings.featuresAvailable,
                      style: TextStyleUtil.k14Bold(),
                    ).paddingOnly(bottom: 16.kh),

                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.AppreciatesConversation ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.appreciatesConversation,
                                image: ImageConstant.svgAmenities1)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.EnjoysMusic ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.enjoysMusic,
                                image: ImageConstant.svgAmenities2)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.SmokeFree ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.smokeFree,
                                image: ImageConstant.svgAmenities3)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.PetFriendly ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.petFriendly,
                                image: ImageConstant.svgAmenities4)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.WinterTires ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.winterTires,
                                image: ImageConstant.svgAmenities5)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.CoolingOrHeating ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.coolingOrHeating,
                                image: ImageConstant.svgAmenities6)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.BabySeat ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.babySeat,
                                image: ImageConstant.svgAmenities7)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.driverBookingDetails
                                ?.preferences?.other?.HeatedSeats ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: Strings.heatedSeats,
                                image: ImageConstant.svgAmenities8)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),

                    const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
                    Text(
                      Strings.description,
                      style: TextStyleUtil.k14Semibold(),
                    ).paddingOnly(bottom: 8.kh),
                    Wrap(
                      children: [
                        Text(controller.myRidesModelData.value
                                .driverBookingDetails?.description ??
                            "NA")
                      ],
                    ),
                    (controller.myRidesModelData.value.driverBookingDetails
                                ?.isStarted ??
                            false)
                        ? GreenPoolButton(
                                label: Strings.viewDetails,
                                onPressed: () => controller.viewOnMap())
                            .paddingSymmetric(vertical: 40.kh)
                        : GreenPoolButton(
                                label: Strings.viewMatchingRiders,
                                onPressed: () =>
                                    controller.viewMatchingRiders())
                            .paddingOnly(bottom: 16.kh, top: 40.kh),
                    Visibility(
                        visible: controller.myRidesModelData.value
                                .driverBookingDetails?.riders?.isNotEmpty ??
                            false,
                        child: InkWell(
                          onTap: () => controller.openMessage(),
                          child: Container(
                            width: 100.w,
                            height: 50.kh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.kh),
                                border:
                                    Border.all(color: ColorUtil.kSecondary01)),
                            child: Text(
                              Strings.message,
                              style: TextStyleUtil.k16Bold(),
                            ),
                          ).paddingOnly(bottom: 40.kh),
                        ))
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              ),
      ),
    );
  }
}

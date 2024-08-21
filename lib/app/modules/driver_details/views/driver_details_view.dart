//! driver details after matching rides page
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../post_ride_step_one/views/amenities.dart';
import '../controllers/driver_details_controller.dart';

class DriverDetailsView extends GetView<DriverDetailsController> {
  const DriverDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.driverDetails),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            controller.rideDetails!['ridesDetails']!['date'] = "";
          },
          child: Padding(
            padding: EdgeInsets.all(8.kh),
            child: SvgPicture.asset(
              ImageConstant.svgIconBack,
              height: 24.kh,
              width: 24.kw,
            ),
          ),
        ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //for profile pic and rating
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
                                  "${controller.matchingRidesModelData.value.driverDetails?[0]?.profilePic?.url}")),
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
                                "${controller.matchingRidesModelData.value.driverDetails?[0]?.fullName}",
                                style: TextStyleUtil.k18Bold(),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: Strings.fare,
                                      style: TextStyleUtil.k16Semibold(
                                          fontSize: 16.kh,
                                          color: ColorUtil.kSecondary01),
                                    ),
                                    TextSpan(
                                      text:
                                          '\$ ${controller.matchingRidesModelData.value.price}',
                                      style: TextStyleUtil.k18Semibold(
                                          color: ColorUtil.kSecondary01),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 8.kh, top: 4.kh),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                    "${GpUtil.getDateFormat(controller.matchingRidesModelData.value.time ?? "")}  ${GpUtil.convertUtcToLocal(controller.matchingRidesModelData.value.time ?? "")}",
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
                                    "${controller.matchingRidesModelData.value.seatAvailable} seats",
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
                ).paddingOnly(top: 8.kh),
                //middle divider
                const GreenPoolDivider(),
                OriginToDestination(
                        needPickupText: true,
                        origin:
                            "${controller.matchingRidesModelData.value.origin?.name}",
                        stop1:
                            "${controller.matchingRidesModelData.value.stops?[0]?.name}",
                        stop2:
                            "${controller.matchingRidesModelData.value.stops?[1]?.name}",
                        destination:
                            "${controller.matchingRidesModelData.value.destination?.name}")
                    .paddingSymmetric(vertical: 8.kh),
                //bottom line
                const GreenPoolDivider(),
              ],
            ).paddingOnly(bottom: 12.kh),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //rating column
                  children: [
                    Text(
                      Strings.rating,
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
                          "${controller.matchingRidesModelData.value.driverDetails?[0]?.rating}",
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
                      Strings.totalRides,
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      "${controller.matchingRidesModelData.value.driverDetails?[0]?.totalRides ?? "0"}",
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
                Column(
                  //joined in column
                  children: [
                    Text(
                      Strings.joined,
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      '${Strings.inA} ${controller.matchingRidesModelData.value.driverDetails?[0]?.createdAt.toString().split("-")[0]}',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(bottom: 12.kh),

            const GreenPoolDivider().paddingOnly(bottom: 16.kh),

            //co passengers
            Text(
              Strings.coPassengers,
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),
            SizedBox(
              height: 76.kh,
              child: ListView.builder(
                itemCount: ((controller.matchingRidesModelData.value
                            ?.ridersDetatils?.length ??
                        0) +
                    (controller.matchingRidesModelData.value?.seatAvailable ??
                        0)),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, passengerIndex) {
                  int ridersCount = controller.matchingRidesModelData.value
                          ?.ridersDetatils?.length ??
                      0;
                  bool isRider = passengerIndex < ridersCount;

                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(20.kh),
                            child: isRider
                                ? CommonImageView(
                                    url:
                                        "${controller.matchingRidesModelData.value.ridersDetatils?[passengerIndex]?.profilePic?.url}")
                                : CommonImageView(
                                    imagePath: ImageConstant.pngEmptyPassenger,
                                  ),
                          ),
                        ),
                      ).paddingOnly(bottom: 4.kh),
                      Text(
                        isRider
                            ? "${controller.matchingRidesModelData.value.ridersDetatils?[passengerIndex]?.fullName.toString().split(" ").first}"
                            : "Empty Seat",
                        style: TextStyleUtil.k12Semibold(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).paddingOnly(right: 18.kw);
                },
              ),
            ),

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
                          "${controller.matchingRidesModelData.value.driverDetails?[0]?.vehicleDetails?[0]?.vehiclePic?.url}"),
                ).paddingOnly(right: 8.kh),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Toyota Corolla',
                      "${controller.matchingRidesModelData.value.driverDetails?[0]?.vehicleDetails?[0]?.model}",
                      style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                    ).paddingOnly(bottom: 4.kh),
                    Row(
                      children: [
                        Text(
                          // 'Sedan',
                          "${controller.matchingRidesModelData.value.driverDetails?[0]?.vehicleDetails?[0]?.type}",
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack03),
                        ),
                        Container(
                          width: 1.kw,
                          height: 16.kh,
                          color: ColorUtil.kBlack03,
                        ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                        Text(
                          "${controller.matchingRidesModelData.value.driverDetails?[0]?.vehicleDetails?[0]?.licencePlate}",
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack03),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(top: 16.kh, bottom: 16.kh),

            //Features available

            Text(
              Strings.featuresAvailable,
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),

            controller.matchingRidesModelData.value.preferences?.other
                        ?.AppreciatesConversation ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.appreciatesConversation,
                        image: ImageConstant.svgAmenities1)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.EnjoysMusic ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.enjoysMusic,
                        image: ImageConstant.svgAmenities2)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.SmokeFree ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.smokeFree,
                        image: ImageConstant.svgAmenities3)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.PetFriendly ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.petFriendly,
                        image: ImageConstant.svgAmenities4)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.WinterTires ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.winterTires,
                        image: ImageConstant.svgAmenities5)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.CoolingOrHeating ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.coolingOrHeating,
                        image: ImageConstant.svgAmenities6)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.BabySeat ==
                    true
                ? Amenities(
                        toggleSwitch: false,
                        text: Strings.babySeat,
                        image: ImageConstant.svgAmenities7)
                    .paddingOnly(bottom: 8.kh)
                : const SizedBox(),
            controller.matchingRidesModelData.value.preferences?.other
                        ?.HeatedSeats ==
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
                Text(
                    controller.matchingRidesModelData.value.description ?? "NA")
              ],
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Obx(
              () => GreenPoolButton(
                      onPressed: () {
                        controller.chatWithDriver();
                      },
                      isLoading: controller.messageBtnLoading.value,
                      loadingColor:
                          Get.find<HomeController>().isPinkModeOn.value
                              ? ColorUtil.kPrimary2PinkMode
                              : ColorUtil.kPrimary01,
                      label: Strings.message,
                      isBorder: true)
                  .paddingOnly(top: 8.kh),
            ),
            GreenPoolButton(
                    onPressed: () => controller.moveToPayment(),
                    label: Strings.requestRide)
                .paddingOnly(bottom: 40.kh, top: 16.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

//! comes after tapping on the driver tile in My Rides
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/post_ride/views/amenities.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_details_controller.dart';

class MyRidesDetailsView extends GetView<MyRidesDetailsController> {
  const MyRidesDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Ride Details'),
      ),
      body: Obx(
        () => controller.myRideDetailsModel.value.data == null
            ? Center(
                child: CircularProgressIndicator(
                color: Get.find<ProfileController>().isSwitched.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kPrimary01,
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //details with pick up and drop off
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Origin to Destination",
                        style: TextStyleUtil.k16Bold(),
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
                                    color: ColorUtil.kGreenColor),
                              ).paddingOnly(right: 8.kw),
                              Text(
                                'Pick up: ',
                                style: TextStyleUtil.k14Semibold(
                                    color: ColorUtil.kBlack02),
                              ).paddingOnly(right: 8.kw),
                              Text(
                                "TEST",
                                // "${controller.myRideDetailsModel.value.data?[0]?.origin?.name}",
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
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorUtil.kError4),
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  'Drop off: ',
                                  style: TextStyleUtil.k14Semibold(
                                      color: ColorUtil.kBlack02),
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  "${controller.myRideDetailsModel.value.data?[0]?.destination?.name}",
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

                  Expanded(
                      child: controller.myRideDetailsModel.value.data?[0]
                                  ?.riders?.length ==
                              0
                          ? Center(
                              child: Text(
                                "At the moment there are no Co-Passengers.",
                                style: TextStyleUtil.k16Regular(),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.myRideDetailsModel.value
                                  .data?[0]?.riders?.length,
                              itemBuilder: (context, index1) {
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
                                                child: controller
                                                            .myRideDetailsModel
                                                            .value
                                                            .data?[0]
                                                            ?.riders
                                                            ?.length ==
                                                        0
                                                    ? Image.asset(
                                                        ImageConstant
                                                            .pngEmptyPassenger,
                                                      )
                                                    : Image(
                                                        image: NetworkImage(
                                                            "${controller.myRideDetailsModel.value.data?[0]?.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.profilePic?.url}"),
                                                      ),
                                              ),
                                            ),
                                          ).paddingOnly(right: 8.kw),
                                          Text(
                                            "${controller.myRideDetailsModel.value.data?[0]?.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.fullName}",
                                            style: TextStyleUtil.k14Semibold(),
                                          )
                                        ],
                                      ).paddingOnly(bottom: 12.kh),
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
                                                'Pick up: ',
                                                style:
                                                    TextStyleUtil.k14Semibold(
                                                        color:
                                                            ColorUtil.kBlack02),
                                              ).paddingOnly(right: 8.kw),
                                              Text(
                                                '${controller.myRideDetailsModel.value.data?[0]?.postsInfo?[index1]?.riderPostsDetails?[0]?.origin?.name}',
                                                style: TextStyleUtil.k14Regular(
                                                    color: ColorUtil.kBlack02),
                                                overflow: TextOverflow.ellipsis,
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
                                                  'Drop off: ',
                                                  style:
                                                      TextStyleUtil.k14Semibold(
                                                          color: ColorUtil
                                                              .kBlack02),
                                                ).paddingOnly(right: 8.kw),
                                                Text(
                                                  '${controller.myRideDetailsModel.value.data?[0]?.postsInfo?[index1]?.riderPostsDetails?[0]?.destination?.name}',
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
                                      const GreenPoolDivider(),
                                    ],
                                  ),
                                );
                              })),
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
                        child: SizedBox(
                          height: 64.kh,
                          width: 64.kw,
                          child: controller.myRideDetailsModel.value.data?[0]
                                      ?.vehicleDetails?[0]?.vehiclePic?.url ==
                                  null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Image(
                                  image: NetworkImage(
                                      "${controller.myRideDetailsModel.value.data?[0]?.vehicleDetails?[0]?.vehiclePic?.url}"),
                                ).paddingOnly(right: 8.kw),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.myRideDetailsModel.value.data?[0]?.vehicleDetails?[0]?.model}',
                            style: TextStyleUtil.k16Bold(
                                color: ColorUtil.kBlack02),
                          ).paddingOnly(bottom: 4.kh),
                          Row(
                            children: [
                              Text(
                                '${controller.myRideDetailsModel.value.data?[0]?.vehicleDetails?[0]?.type}',
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
                                '${controller.myRideDetailsModel.value.data?[0]?.vehicleDetails?[0]?.licencePlate}',
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
                    'Features available',
                    style: TextStyleUtil.k14Bold(),
                  ).paddingOnly(bottom: 16.kh),

                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.AppreciatesConversation ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Appreciates Conversation",
                              image: ImageConstant.svgAmenities1)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.EnjoysMusic ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Enjoys Music",
                              image: ImageConstant.svgAmenities2)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.SmokeFree ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Some-Free",
                              image: ImageConstant.svgAmenities3)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.PetFriendly ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Pet-friendly",
                              image: ImageConstant.svgAmenities4)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.WinterTires ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Winter Tires",
                              image: ImageConstant.svgAmenities5)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.CoolingOrHeating ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Cooling or Heating",
                              image: ImageConstant.svgAmenities6)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.BabySeat ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Baby Seats",
                              image: ImageConstant.svgAmenities7)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),
                  controller.myRideDetailsModel.value.data?[0]?.preferences
                              ?.other?.HeatedSeats ==
                          true
                      ? Amenities(
                              toggleSwitch: false,
                              text: "Heated Seats",
                              image: ImageConstant.svgAmenities8)
                          .paddingOnly(bottom: 8.kh)
                      : const SizedBox(),

                  const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
                  Text(
                    "Description",
                    style: TextStyleUtil.k14Semibold(),
                  ),
                  GreenPoolButton(
                      label: "View Matching Riders",
                      onPressed: () {
                        Get.toNamed(Routes.MY_RIDES_REQUEST,
                            arguments: controller.driverId);
                      }).paddingSymmetric(vertical: 40.kh)
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

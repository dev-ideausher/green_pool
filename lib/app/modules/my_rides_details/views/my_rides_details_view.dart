//! comes after tapping on the driver tile in My Rides
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
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
        () => controller.isLoad.value
            ?GpProgress():
            SizedBox() /*SingleChildScrollView(
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
                                      Get.find<ProfileController>()
                                              .isSwitched
                                              .value
                                          ? ColorUtil.kPrimary3PinkMode
                                          : ColorUtil.kSecondary01,
                                      BlendMode.srcIn),
                                ).paddingOnly(right: 8.kw),
                                Text(
                                  // "7 July 2023, 3:00pm",
                                  "${controller.myRidesModelData.value.date.toString().split("T").first}  ${controller.myRidesModelData.value.time}",
                                  style: TextStyleUtil.k16Bold(
                                      color: ColorUtil.kBlack02),
                                )
                              ],
                            ),
                            Text(
                              "Fare: ${controller.myRidesModelData.value.fair}",
                              style: TextStyleUtil.k16Semibold(
                                  fontSize: 16.kh,
                                  color: ColorUtil.kSecondary01),
                            ),
                          ],
                        ),
                        const GreenPoolDivider()
                            .paddingSymmetric(vertical: 16.kh),
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
                                  "${controller.myRidesModelData.value.origin?.name}",
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
                                    "${controller.myRidesModelData.value.destination?.name}",
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

                    controller.myRidesModelData.value.postsInfo?.length == 0
                        ? Center(
                            child: Text(
                              "At the moment there are no Co-Passengers.",
                              style: TextStyleUtil.k16Regular(),
                            ),
                          )
                        : SizedBox(
                            height: controller
                                    .myRidesModelData.value.postsInfo!.length *
                                122.kh,
                            child: ListView.builder(
                                itemCount: controller
                                    .myRidesModelData.value.postsInfo?.length,
                                physics: const NeverScrollableScrollPhysics(),
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
                                                              .myRidesModelData
                                                              .value
                                                              .postsInfo
                                                              ?.length ==
                                                          0
                                                      ? Image.asset(
                                                          ImageConstant
                                                              .pngEmptyPassenger,
                                                        )
                                                      : Image(
                                                          image: NetworkImage(
                                                              "${controller.myRidesModelData.value.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.profilePic?.url}"),
                                                        ),
                                                ),
                                              ),
                                            ).paddingOnly(right: 8.kw),
                                            Text(
                                              "${controller.myRidesModelData.value.postsInfo?[index1]?.riderPostsDetails?[0]?.ridersDetails?[0]?.fullName}",
                                              style:
                                                  TextStyleUtil.k14Semibold(),
                                            )
                                          ],
                                        ).paddingOnly(bottom: 12.kh),
                                        OriginToDestination(
                                                origin:
                                                    '${controller.myRidesModelData.value.postsInfo?[index1]?.riderPostsDetails?[0]?.origin?.name}',
                                                destination:
                                                    '${controller.myRidesModelData.value.postsInfo?[index1]?.riderPostsDetails?[0]?.destination?.name}')
                                            .paddingOnly(bottom: 8.kh),
                                        //bottom line
                                        const GreenPoolDivider(),
                                      ],
                                    ),
                                  );
                                }),
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
                          child: SizedBox(
                            height: 64.kh,
                            width: 64.kw,
                            child: controller.myRidesModelData.value
                                        .vehicleDetails?[0]?.vehiclePic?.url ==
                                    null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Image(
                                    image: NetworkImage(
                                        "${controller.myRidesModelData.value.vehicleDetails?[0]?.vehiclePic?.url}"),
                                  ).paddingOnly(right: 8.kw),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.myRidesModelData.value.vehicleDetails?[0]?.model}',
                              style: TextStyleUtil.k16Bold(
                                  color: ColorUtil.kBlack02),
                            ).paddingOnly(bottom: 4.kh),
                            Row(
                              children: [
                                Text(
                                  '${controller.myRidesModelData.value.vehicleDetails?[0]?.type}',
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
                                  '${controller.myRidesModelData.value.vehicleDetails?[0]?.licencePlate}',
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

                    controller.myRidesModelData.value.preferences?.other
                                ?.AppreciatesConversation ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Appreciates Conversation",
                                image: ImageConstant.svgAmenities1)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.EnjoysMusic ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Enjoys Music",
                                image: ImageConstant.svgAmenities2)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.SmokeFree ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Some-Free",
                                image: ImageConstant.svgAmenities3)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.PetFriendly ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Pet-friendly",
                                image: ImageConstant.svgAmenities4)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.WinterTires ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Winter Tires",
                                image: ImageConstant.svgAmenities5)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.CoolingOrHeating ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Cooling or Heating",
                                image: ImageConstant.svgAmenities6)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.BabySeat ==
                            true
                        ? Amenities(
                                toggleSwitch: false,
                                text: "Baby Seats",
                                image: ImageConstant.svgAmenities7)
                            .paddingOnly(bottom: 8.kh)
                        : const SizedBox(),
                    controller.myRidesModelData.value.preferences?.other
                                ?.HeatedSeats ==
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
                    ).paddingOnly(bottom: 8.kh),
                    Wrap(
                      children: [
                        Text("${controller.myRidesModelData.value.description}")
                      ],
                    ),
                    GreenPoolButton(
                        label: "View Matching Riders",
                        onPressed: () {
                          Get.toNamed(Routes.MY_RIDES_REQUEST,
                              arguments: controller.myRidesModelData.value.Id);
                        }).paddingSymmetric(vertical: 40.kh)
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              )*/,
      ),
    );
  }
}

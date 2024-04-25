import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';

class RiderSendRequest extends GetView<RiderMyRideRequestController> {
  const RiderSendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const GpProgress()
          : controller.riderSendRequestModel.value.data!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: SvgPicture.asset(ImageConstant.svgNoRides)),
                    Text(
                      "There are no rides between these two cities",
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.kh),
                    Text(
                      "Please try again after few days.",
                      style:
                          TextStyleUtil.k18Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount:
                      controller.riderSendRequestModel.value.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.RIDER_MY_RIDES_SEND_DETAILS,
                            arguments: index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.kh),
                        decoration: BoxDecoration(
                            color: ColorUtil.kWhiteColor,
                            borderRadius: BorderRadius.circular(8.kh),
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorUtil.kNeutral7, width: 2.kh))),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //for profile pic and rating
                                Stack(
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.kh),
                                        child: Image(
                                            height: 64.kh,
                                            width: 64.kw,
                                            image: NetworkImage(
                                                "${controller.riderSendRequestModel.value.data![index]?.driverDetails![0]?.profilePic?.url}")),
                                      ),
                                    ).paddingOnly(bottom: 8.kh),
                                    Positioned(
                                      top: 52.kh,
                                      left: 8.kw,
                                      child: Container(
                                        width: 48.kw,
                                        height: 20.kh,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.kw),
                                        decoration: BoxDecoration(
                                            color: Get.find<ProfileController>()
                                                    .isSwitched
                                                    .value
                                                ? ColorUtil.kPrimary3PinkMode
                                                : ColorUtil.kSecondary01,
                                            borderRadius:
                                                BorderRadius.circular(16.kh)),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color:
                                                  Get.find<ProfileController>()
                                                          .isSwitched
                                                          .value
                                                      ? ColorUtil.kWhiteColor
                                                      : ColorUtil.kYellowColor,
                                              size: 12.kh,
                                            ).paddingOnly(right: 2.kw),
                                            Text(
                                              // '0.0',
                                              controller
                                                      .riderSendRequestModel
                                                      .value
                                                      .data?[index]
                                                      ?.driverDetails?[0]!
                                                      .rating
                                                      ?.toStringAsFixed(1) ??
                                                  '0.0',
                                              style: TextStyleUtil.k12Semibold(
                                                  color: Get.find<
                                                              ProfileController>()
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      //TODO: space between
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // 'Esther Howard',
                                          controller
                                              .riderSendRequestModel
                                              .value
                                              .data![index]!
                                              .driverDetails![0]!
                                              .fullName
                                              .toString(),
                                          style: TextStyleUtil.k16Semibold(
                                              fontSize: 16.kh),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                // text: '\$3.50',
                                                text:
                                                    "\$ ${controller.riderSendRequestModel.value.data![index]?.origin?.originDestinationFair ?? "0"}",
                                                style: TextStyleUtil.k16Bold(
                                                    color:
                                                        ColorUtil.kSecondary01),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            controller
                                                        .riderSendRequestModel
                                                        .value
                                                        .data![index]
                                                        ?.date ==
                                                    null
                                                ? const SizedBox()
                                                : SvgPicture.asset(
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
                                            controller
                                                        .riderSendRequestModel
                                                        .value
                                                        .data![index]
                                                        ?.date ==
                                                    null
                                                ? const SizedBox()
                                                : Text(
                                                    // '07 July 2023, 3:00pm',
                                                    "${controller.riderSendRequestModel.value.data![index]?.date?.split('T')[0] ?? ""}  ${controller.riderSendRequestModel.value.data![index]?.time ?? ""}",
                                                    style: TextStyleUtil
                                                        .k12Regular(
                                                            color: ColorUtil
                                                                .kBlack02),
                                                  ),
                                          ],
                                        ),
                                        //TODO: space between
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.time_to_leave,
                                              size: 18.kh,
                                              color:
                                                  Get.find<ProfileController>()
                                                          .isSwitched
                                                          .value
                                                      ? ColorUtil
                                                          .kPrimary3PinkMode
                                                      : ColorUtil.kSecondary01,
                                            ).paddingOnly(right: 8.kw),
                                            Text(
                                              '${controller.riderSendRequestModel.value.data![index]?.seatAvailable ?? "0"} seats',
                                              style: TextStyleUtil.k14Regular(
                                                  color: ColorUtil.kBlack03),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).paddingOnly(top: 8.kh),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40.kh),
                                            border: Border.all(
                                                color: ColorUtil.kSecondary01)),
                                        child: Text(
                                          "Message",
                                          style: TextStyleUtil.k12Semibold(),
                                        ).paddingSymmetric(
                                            vertical: 4.kh, horizontal: 16.kw),
                                      ),
                                    ).paddingSymmetric(vertical: 8.kh),
                                  ],
                                ),
                              ],
                            ),
                            const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                            OriginToDestination(
                                    needPickupText: false,
                                    origin:
                                        "${controller.riderSendRequestModel.value.data![index]?.origin?.name}",
                                    destination:
                                        "${controller.riderSendRequestModel.value.data![index]?.destination?.name}")
                                .paddingOnly(bottom: 8.kh),
                            const GreenPoolDivider().paddingOnly(bottom: 16.kh),
                            //

                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GreenPoolButton(
                                  width: 144.kw,
                                  height: 40.kh,
                                  padding: EdgeInsets.all(8.kh),
                                  fontSize: 14.kh,
                                  label: 'Request',
                                  onPressed: () async {
                                    await controller
                                        .sendRideRequestToDriverAPI(index);
                                    await Get.bottomSheet(
                                      Container(
                                          padding: EdgeInsets.all(24.kh),
                                          // height: 317.kh,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: ColorUtil.kWhiteColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(40.kh),
                                                  topRight:
                                                      Radius.circular(40.kh))),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Request Sent',
                                                style: TextStyleUtil
                                                    .k18Heading600(),
                                              ).paddingOnly(bottom: 24.kh),
                                              SvgPicture.asset(
                                                ImageConstant.svgCompleteTick,
                                                height: 64.kh,
                                                width: 64.kw,
                                              ).paddingOnly(bottom: 16.kh),
                                              Text(
                                                "Payment Successful!\nRide request has been sent to the driver.\nYour booking is awaiting the driver'sapproval.",
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyleUtil.k16Semibold(
                                                        fontSize: 16.kh),
                                              ).paddingOnly(bottom: 40.kh),
                                              GreenPoolButton(
                                                  label: 'Continue',
                                                  onPressed: () {
                                                    Get.until((route) =>
                                                        Get.currentRoute ==
                                                        Routes
                                                            .BOTTOM_NAVIGATION);
                                                  }),
                                              GreenPoolButton(
                                                  label: 'Cancel Request',
                                                  isBorder: true,
                                                  onPressed: () {
                                                    Get.until((route) =>
                                                        Get.currentRoute ==
                                                        Routes
                                                            .BOTTOM_NAVIGATION);
                                                  }).paddingOnly(top: 16.kh),
                                            ],
                                          )),
                                    );
                                    // Get.bottomSheet(
                                    //   Container(
                                    //       padding: EdgeInsets.all(24.kh),
                                    //       // height: 317.kh,
                                    //       width: 100.w,
                                    //       decoration: BoxDecoration(
                                    //           color: ColorUtil.kWhiteColor,
                                    //           borderRadius: BorderRadius.only(
                                    //               topLeft: Radius.circular(40.kh),
                                    //               topRight: Radius.circular(40.kh))),
                                    //       child: Column(
                                    //         children: [
                                    //           Text(
                                    //             'Rider Request',
                                    //             style: TextStyleUtil.k18Semibold(),
                                    //           ).paddingOnly(bottom: 16.kh),
                                    //           Column(children: [
                                    //             Row(
                                    //               children: [
                                    //                 Container(
                                    //                   decoration: const BoxDecoration(
                                    //                       shape: BoxShape.circle),
                                    //                   child: ClipOval(
                                    //                     child: SizedBox.fromSize(
                                    //                       size: Size.fromRadius(20.kh),
                                    //                       child: Image.asset(
                                    //                         ImageConstant.pngPassenger2,
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ).paddingOnly(right: 8.kw),
                                    //                 Column(
                                    //                   crossAxisAlignment:
                                    //                       CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Text(
                                    //                       'Esther Howard',
                                    //                       style:
                                    //                           TextStyleUtil.k16Semibold(
                                    //                               fontSize: 16.kh),
                                    //                     ).paddingOnly(bottom: 8.kh),
                                    //                     Row(
                                    //                       mainAxisAlignment:
                                    //                           MainAxisAlignment
                                    //                               .spaceBetween,
                                    //                       children: [
                                    //                         Row(
                                    //                           children: [
                                    //                             SvgPicture.asset(
                                    //                               ImageConstant
                                    //                                   .svgIconCalendarTime,
                                    //                               colorFilter: ColorFilter.mode(
                                    //                                   Get.find<ProfileController>()
                                    //                                           .isSwitched
                                    //                                           .value
                                    //                                       ? ColorUtil
                                    //                                           .kPrimary3PinkMode
                                    //                                       : ColorUtil
                                    //                                           .kSecondary01,
                                    //                                   BlendMode.srcIn),
                                    //                             ).paddingOnly(
                                    //                                 right: 4.kw),
                                    //                             Text(
                                    //                               '07 July 2023, 3:00pm',
                                    //                               style: TextStyleUtil
                                    //                                   .k12Regular(
                                    //                                       color: ColorUtil
                                    //                                           .kBlack02),
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                         Row(
                                    //                           children: [
                                    //                             Icon(
                                    //                               Icons.location_on,
                                    //                               size: 16.kh,
                                    //                               color: Get.find<
                                    //                                           ProfileController>()
                                    //                                       .isSwitched
                                    //                                       .value
                                    //                                   ? ColorUtil
                                    //                                       .kPrimary3PinkMode
                                    //                                   : ColorUtil
                                    //                                       .kSecondary01,
                                    //                             ),
                                    //                             Text(
                                    //                               '2.1 km away',
                                    //                               style: TextStyleUtil
                                    //                                   .k12Regular(
                                    //                                       color: ColorUtil
                                    //                                           .kBlack02),
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             Container(
                                    //               width: 100.w,
                                    //               height: 1.kh,
                                    //               color: ColorUtil.kBlack07,
                                    //             ).paddingOnly(bottom: 16.kh),
                                    //             Stack(
                                    //               children: [
                                    //                 Row(
                                    //                   children: [
                                    //                     Container(
                                    //                       height: 10.kh,
                                    //                       width: 10.kw,
                                    //                       decoration:
                                    //                           const BoxDecoration(
                                    //                               shape:
                                    //                                   BoxShape.circle,
                                    //                               color: ColorUtil
                                    //                                   .kGreenColor),
                                    //                     ).paddingOnly(right: 8.kw),
                                    //                     Text(
                                    //                       '1100 McIntosh St, Regina',
                                    //                       style:
                                    //                           TextStyleUtil.k14Regular(
                                    //                               color: ColorUtil
                                    //                                   .kBlack02),
                                    //                     ),
                                    //                   ],
                                    //                 ).paddingOnly(bottom: 30.kh),
                                    //                 Positioned(
                                    //                   top: 27.kh,
                                    //                   child: Row(
                                    //                     children: [
                                    //                       Container(
                                    //                         height: 10.kh,
                                    //                         width: 10.kw,
                                    //                         decoration:
                                    //                             const BoxDecoration(
                                    //                                 shape:
                                    //                                     BoxShape.circle,
                                    //                                 color: ColorUtil
                                    //                                     .kError4),
                                    //                       ).paddingOnly(right: 8.kw),
                                    //                       Text(
                                    //                         '681 Chrislea Rd, Woodbridge',
                                    //                         style: TextStyleUtil
                                    //                             .k14Regular(
                                    //                                 color: ColorUtil
                                    //                                     .kBlack02),
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ),
                                    //                 Positioned(
                                    //                   top: 10.kh,
                                    //                   left: 4.5.kw,
                                    //                   child: Container(
                                    //                     height: 28.kh,
                                    //                     width: 1.kw,
                                    //                     color: ColorUtil.kBlack04,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ).paddingOnly(bottom: 8.kh),
                                    //             const GreenPoolDivider()
                                    //                 .paddingOnly(bottom: 16.kh),
                                    //             Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.spaceBetween,
                                    //               children: [
                                    //                 Column(
                                    //                   //rating column
                                    //                   children: [
                                    //                     Text(
                                    //                       'Rating',
                                    //                       style: TextStyleUtil
                                    //                           .k12Semibold(),
                                    //                     ).paddingOnly(bottom: 4.kh),
                                    //                     Container(
                                    //                       padding: EdgeInsets.symmetric(
                                    //                           horizontal: 12.kw,
                                    //                           vertical: 2.kh),
                                    //                       decoration: BoxDecoration(
                                    //                         color: Get.find<
                                    //                                     ProfileController>()
                                    //                                 .isSwitched
                                    //                                 .value
                                    //                             ? ColorUtil
                                    //                                 .kPrimary3PinkMode
                                    //                             : ColorUtil.kPrimary01,
                                    //                         borderRadius:
                                    //                             BorderRadius.circular(
                                    //                                 16.kh),
                                    //                       ),
                                    //                       child: Row(children: [
                                    //                         Icon(
                                    //                           Icons.star,
                                    //                           color:
                                    //                               ColorUtil.kWhiteColor,
                                    //                           size: 12.kh,
                                    //                         ).paddingOnly(right: 4.kw),
                                    //                         Text(
                                    //                           '4.5',
                                    //                           style: TextStyleUtil
                                    //                               .k14Regular(),
                                    //                         ),
                                    //                       ]),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 Column(
                                    //                   //ride with column
                                    //                   children: [
                                    //                     Text(
                                    //                       'Ride With',
                                    //                       style: TextStyleUtil
                                    //                           .k12Semibold(),
                                    //                     ).paddingOnly(bottom: 4.kh),
                                    //                     Text(
                                    //                       '32 people',
                                    //                       style:
                                    //                           TextStyleUtil.k14Regular(
                                    //                               color: ColorUtil
                                    //                                   .kBlack03),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 Column(
                                    //                   //joined in column
                                    //                   children: [
                                    //                     Text(
                                    //                       'Joined',
                                    //                       style: TextStyleUtil
                                    //                           .k12Semibold(),
                                    //                     ).paddingOnly(bottom: 4.kh),
                                    //                     Text(
                                    //                       'in 2023',
                                    //                       style:
                                    //                           TextStyleUtil.k14Regular(
                                    //                               color: ColorUtil
                                    //                                   .kBlack03),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //             const GreenPoolDivider().paddingOnly(
                                    //                 bottom: 16.kh, top: 8.kh),
                                    //             GreenPoolButton(
                                    //               onPressed: () => Get.back(),
                                    //               label: 'Request Rider',
                                    //               fontSize: 14.kh,
                                    //               height: 40.kh,
                                    //               width: 144.kw,
                                    //               padding: EdgeInsets.all(8.kh),
                                    //             ),
                                    //           ]),
                                    //         ],
                                    //       )),
                                    // ),
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ).paddingOnly(bottom: 16.kh),
                    );
                  },
                ).paddingOnly(top: 32.kh, left: 16.kw, right: 16.kw),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/modules/map_driver_send_request/controllers/map_driver_send_request_controller.dart';
import 'package:green_pool/app/modules/map_driver_send_request/views/map_driver_send_request_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/my_rides_request_controller.dart';

class SendRequest extends GetView<MyRidesRequestController> {
  const SendRequest({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => MapDriverSendRequestController(),
    );
    return Obx(
      () => controller.sendRequestModel.value.data == null
          ? const GpProgress()
          : controller.sendRequestModel.value.data!.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Get.find<HomeController>().isPinkModeOn.value
                          ? CommonImageView(
                              svgPath: ImageConstant.svgNoRidesPink,
                            )
                          : SvgPicture.asset(ImageConstant.svgNoRides),
                    ),
                    Text(
                      Strings.noRidesBetweenCities,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 16.kh),
                    Text(
                      Strings.pleaseTryAgain,
                      style:
                          TextStyleUtil.k18Regular(color: ColorUtil.kBlack04),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : controller.mapViewType.value
                  ? const MapDriverSendRequestView()
                  : ListView.builder(
                      itemCount:
                          controller.sendRequestModel.value.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(16.kh),
                          decoration: BoxDecoration(
                              color: ColorUtil.kWhiteColor,
                              borderRadius: BorderRadius.circular(8.kh),
                              border: Border(
                                  bottom: BorderSide(
                                      color: ColorUtil.kNeutral7,
                                      width: 2.kh))),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: ClipOval(
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(20.kh),
                                            child: CommonImageView(
                                                url:
                                                    "${controller.sendRequestModel.value.data![index]!.riderDetails?[0]?.profilePic?.url}"))),
                                  ).paddingOnly(right: 8.kw),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'full name',
                                        controller
                                            .sendRequestModel
                                            .value
                                            .data![index]!
                                            .riderDetails![0]!
                                            .fullName
                                            .toString(),
                                        style: TextStyleUtil.k16Semibold(
                                            fontSize: 16.kh),
                                      ).paddingOnly(bottom: 8.kh),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                ImageConstant
                                                    .svgIconCalendarTime,
                                                colorFilter: ColorFilter.mode(
                                                    Get.find<HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                                    BlendMode.srcIn),
                                              ).paddingOnly(right: 4.kw),
                                              Text(
                                                // '07 July 2023, 3:00pm',
                                                "${controller.sendRequestModel.value.data![index]?.date?.split('T')[0] ?? ""}  ${controller.sendRequestModel.value.data![index]?.time ?? ""}",
                                                style: TextStyleUtil.k12Regular(
                                                    color: ColorUtil.kBlack02),
                                              ),
                                            ],
                                          ),
                                          //TODO: spacing
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 16.kh,
                                                color:
                                                    Get.find<HomeController>()
                                                            .isPinkModeOn
                                                            .value
                                                        ? ColorUtil
                                                            .kPrimary3PinkMode
                                                        : ColorUtil
                                                            .kSecondary01,
                                              ),
                                              Text(
                                                // '2.1 km away',
                                                "${GpUtil.calculateDistance(startLat: controller.latitude, startLong: controller.longitude, endLat: controller.sendRequestModel.value.data?[index]?.origin?.coordinates?.last ?? controller.latitude, endLong: controller.sendRequestModel.value.data?[index]?.origin?.coordinates?.first ?? controller.longitude).toStringAsFixed(2)} ${Strings.kmAway}",
                                                style: TextStyleUtil.k12Regular(
                                                    color: ColorUtil.kBlack02),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40.kh),
                                              border: Border.all(
                                                  color:
                                                      ColorUtil.kSecondary01)),
                                          child: Text(
                                            Strings.message,
                                            style: TextStyleUtil.k12Semibold(),
                                          ).paddingSymmetric(
                                              vertical: 4.kh,
                                              horizontal: 16.kw),
                                        ),
                                      ).paddingSymmetric(vertical: 8.kh),
                                    ],
                                  ),
                                ],
                              ),
                              const GreenPoolDivider()
                                  .paddingOnly(bottom: 16.kh),
                              OriginToDestination(
                                      origin:
                                          "${controller.sendRequestModel.value.data![index]?.origin?.name}",
                                      destination:
                                          "${controller.sendRequestModel.value.data![index]?.destination?.name}",
                                      needPickupText: false)
                                  .paddingOnly(bottom: 8.kh),
                              const GreenPoolDivider()
                                  .paddingOnly(bottom: 16.kh),
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
                                    label: Strings.request,
                                    onPressed: () async {
                                      await controller
                                          .sendRiderRequestAPI(index);
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
                                                    topRight: Radius.circular(
                                                        40.kh))),
                                            child: Column(
                                              children: [
                                                Text(
                                                  Strings.requestSent,
                                                  style: TextStyleUtil
                                                      .k18Heading600(),
                                                ).paddingOnly(bottom: 24.kh),
                                                SvgPicture.asset(
                                                  ImageConstant.svgCompleteTick,
                                                  height: 64.kh,
                                                  width: 64.kw,
                                                ).paddingOnly(bottom: 16.kh),
                                                Text(
                                                  Strings.paymentDoneRequestSentToDriver,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyleUtil.k16Semibold(
                                                          fontSize: 16.kh),
                                                ).paddingOnly(bottom: 40.kh),
                                                GreenPoolButton(
                                                    label: Strings.continueText,
                                                    onPressed: () {
                                                      Get.until((route) =>
                                                          Get.currentRoute ==
                                                          Routes
                                                              .BOTTOM_NAVIGATION);
                                                    }),
                                                GreenPoolButton(
                                                    label: Strings.cancelRequest,
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
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).paddingOnly(bottom: 16.kh);
                      },
                    ).paddingOnly(top: 32.kh, left: 16.kw, right: 16.kw),
    );
  }
}
//? this is for map view
// await Get.bottomSheet(
                                      //   Container(
                                      //       padding: EdgeInsets.all(24.kh),
                                      //       // height: 317.kh,
                                      //       width: 100.w,
                                      //       decoration: BoxDecoration(
                                      //           color: ColorUtil.kWhiteColor,
                                      //           borderRadius: BorderRadius.only(
                                      //               topLeft: Radius.circular(40.kh),
                                      //               topRight:
                                      //                   Radius.circular(40.kh))),
                                      //       child: Column(
                                      //         children: [
                                      //           Text(
                                      //             'Rider Request',
                                      //             style:
                                      //                 TextStyleUtil.k18Semibold(),
                                      //           ).paddingOnly(bottom: 16.kh),
                                      //           Column(children: [
                                      //             Row(
                                      //               children: [
                                      //                 Container(
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                           shape: BoxShape
                                      //                               .circle),
                                      //                   child: ClipOval(
                                      //                     child: SizedBox.fromSize(
                                      //                       size: Size.fromRadius(
                                      //                           20.kh),
                                      //                       child: Image.asset(
                                      //                         ImageConstant
                                      //                             .pngPassenger2,
                                      //                       ),
                                      //                     ),
                                      //                   ),
                                      //                 ).paddingOnly(right: 8.kw),
                                      //                 Column(
                                      //                   crossAxisAlignment:
                                      //                       CrossAxisAlignment
                                      //                           .start,
                                      //                   children: [
                                      //                     Text(
                                      //                       'Esther Howard',
                                      //                       style: TextStyleUtil
                                      //                           .k16Semibold(
                                      //                               fontSize:
                                      //                                   16.kh),
                                      //                     ).paddingOnly(
                                      //                         bottom: 8.kh),
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
                                      //                                   Get.find<HomeController>()
                                      //                                           .isPinkModeOn
                                      //                                           .value
                                      //                                       ? ColorUtil
                                      //                                           .kPrimary3PinkMode
                                      //                                       : ColorUtil
                                      //                                           .kSecondary01,
                                      //                                   BlendMode
                                      //                                       .srcIn),
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
                                      //                               Icons
                                      //                                   .location_on,
                                      //                               size: 16.kh,
                                      //                               color: Get.find<
                                      //                                           HomeController>()
                                      //                                       .isPinkModeOn
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
                                      //                               shape: BoxShape
                                      //                                   .circle,
                                      //                               color: ColorUtil
                                      //                                   .kGreenColor),
                                      //                     ).paddingOnly(
                                      //                         right: 8.kw),
                                      //                     Text(
                                      //                       '1100 McIntosh St, Regina',
                                      //                       style: TextStyleUtil
                                      //                           .k14Regular(
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
                                      //                                 shape: BoxShape
                                      //                                     .circle,
                                      //                                 color: ColorUtil
                                      //                                     .kError4),
                                      //                       ).paddingOnly(
                                      //                           right: 8.kw),
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
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               children: [
                                      //                 Column(
                                      //                   //rating column
                                      //                   children: [
                                      //                     Text(
                                      //                       'Rating',
                                      //                       style: TextStyleUtil
                                      //                           .k12Semibold(),
                                      //                     ).paddingOnly(
                                      //                         bottom: 4.kh),
                                      //                     Container(
                                      //                       padding: EdgeInsets
                                      //                           .symmetric(
                                      //                               horizontal:
                                      //                                   12.kw,
                                      //                               vertical: 2.kh),
                                      //                       decoration:
                                      //                           BoxDecoration(
                                      //                         color: Get.find<
                                      //                                     HomeController>()
                                      //                                 .isPinkModeOn
                                      //                                 .value
                                      //                             ? ColorUtil
                                      //                                 .kPrimary3PinkMode
                                      //                             : ColorUtil
                                      //                                 .kPrimary01,
                                      //                         borderRadius:
                                      //                             BorderRadius
                                      //                                 .circular(
                                      //                                     16.kh),
                                      //                       ),
                                      //                       child: Row(children: [
                                      //                         Icon(
                                      //                           Icons.star,
                                      //                           color: ColorUtil
                                      //                               .kWhiteColor,
                                      //                           size: 12.kh,
                                      //                         ).paddingOnly(
                                      //                             right: 4.kw),
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
                                      //                     ).paddingOnly(
                                      //                         bottom: 4.kh),
                                      //                     Text(
                                      //                       '32 people',
                                      //                       style: TextStyleUtil
                                      //                           .k14Regular(
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
                                      //                     ).paddingOnly(
                                      //                         bottom: 4.kh),
                                      //                     Text(
                                      //                       'in 2023',
                                      //                       style: TextStyleUtil
                                      //                           .k14Regular(
                                      //                               color: ColorUtil
                                      //                                   .kBlack03),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             const GreenPoolDivider()
                                      //                 .paddingOnly(
                                      //                     bottom: 16.kh, top: 8.kh),
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
                                      // );
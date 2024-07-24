import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';

class RiderRequestSendDriverBottomsheet extends StatelessWidget {
  RiderSendRequestModelData element;

  RiderRequestSendDriverBottomsheet({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24.kh),
        // height: 317.kh,
        width: 100.w,
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              Strings.driverRequest,
              style: TextStyleUtil.k18Heading600(),
            ).paddingOnly(bottom: 12.kh),
            const GreenPoolDivider().paddingSymmetric(vertical: 8.kh),
            Row(
              children: [
                //for profile pic and rating
                ClipRRect(
                        borderRadius: BorderRadius.circular(8.kh),
                        child: CommonImageView(
                            height: 64.kh,
                            width: 64.kw,
                            url:
                                "${element?.driverDetails?.firstOrNull?.profilePic?.url}"))
                    .paddingOnly(right: 16.kw, bottom: 8.kh),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${element?.driverDetails?.firstOrNull?.fullName}",
                          style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                        ),
                        8.kwidthBox,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "\$ ${(element?.origin?.originDestinationFair ?? 0)}",
                                style: TextStyleUtil.k16Bold(
                                    color: ColorUtil.kSecondary01),
                              ),
                            ],
                          ),
                        ),
                        8.kwidthBox,
                        InkWell(
                          onTap: () => Get.find<RiderMyRideRequestController>()
                              .openMessage(element),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.kh),
                                border:
                                    Border.all(color: ColorUtil.kSecondary01)),
                            child: Text(
                              Strings.message,
                              style: TextStyleUtil.k12Semibold(),
                            ).paddingSymmetric(
                                vertical: 4.kh, horizontal: 16.kw),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
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
                              "${GpUtil.getDateFormat(element.time ?? "")}  ${GpUtil.convertUtcToLocal(element.time ?? "")}",
                              style: TextStyleUtil.k12Regular(
                                  color: ColorUtil.kBlack02),
                            ),
                          ],
                        ).paddingOnly(right: 10.kw),
                        Row(
                          children: [
                            Icon(
                              Icons.time_to_leave,
                              size: 18.kh,
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimary3PinkMode
                                      : ColorUtil.kSecondary01,
                            ).paddingOnly(right: 5.kw),
                            Text(
                              '${element.seatAvailable} seats',
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kBlack03),
                            ),
                          ],
                        ).paddingOnly(top: 8.kh),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
            OriginToDestination(
                    origin: element?.origin?.name ?? "",
                    destination: element?.destination?.name ?? "",
                    needPickupText: false)
                .paddingOnly(bottom: 8.kh),
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
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
                          color: ColorUtil.kWhiteColor,
                          size: 12.kh,
                        ).paddingOnly(right: 4.kw),
                        Text(
                          element?.driverDetails?.firstOrNull?.rating
                                  .toString() ??
                              "0.0",
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
                      Strings.rideWith,
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      element?.driverDetails?.firstOrNull?.totalRides
                              .toString() ??
                          "0" + ' people',
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
                      '${Strings.inA} ${element?.driverDetails?.firstOrNull?.createdAt?.substring(0, 4) ?? 2024}',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(bottom: 16.kh, top: 8.kh),
            /*ListTile(
              title: Text(Strings.coPassengers),
              contentPadding: EdgeInsets.zero,
            ),
            SizedBox(
                height: 40.kh,
                child: ListView.builder(
                  itemCount: element.ridersDetatils?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CircleAvatar(
                    backgroundImage: NetworkImage(
                        element.ridersDetatils?[index]?.profilePic?.url ?? ""),
                  ),
                )),*/
            GreenPoolButton(
              onPressed: () {
                if (element.requestSent ?? false) {
                  showMySnackbar(msg: "The request has already been sent.");
                } else {
                  Get.find<RiderMyRideRequestController>()
                      .moveToPaymentFromSendRequest(element!);
                }
              },
              label: element.requestSent ?? false
                  ? Strings.sent
                  : Strings.sendRequest,
              fontSize: 14.kh,
              height: 40.kh,
              width: 144.kw,
              padding: EdgeInsets.all(8.kh),
            ),
          ]),
        ));
  }

  Widget text(String s) {
    return Text(
      s,
      style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/data/driver_send_request_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../services/utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';
import '../../my_rides_request/controllers/my_rides_request_controller.dart';

class RiderRequestBottomsheet extends StatelessWidget {
  DriverSendRequestModelData element;

  RiderRequestBottomsheet({super.key, required this.element});

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
              LocaleKeys.app_riderRequest.tr,
              style: TextStyleUtil.k18Heading600(),
            ).paddingOnly(bottom: 4.kh),
            const GreenPoolDivider().paddingSymmetric(vertical: 8.kh),
            ListTile(
              leading: ClipOval(
                child: SizedBox.fromSize(
                    size: Size.fromRadius(20.kh),
                    child: CommonImageView(
                      url: element.riderDetails?.profilePic?.url,
                    )),
              ),
              title: Text(
                element.riderDetails?.fullName ?? "",
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
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
                    ("${DateTimeUtils.getDateFormat(element.time ?? "")}, ${DateTimeUtils.convertUtcToLocal(element.time ?? "")}"),
                    style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack02),
                  ),
                ],
              ).paddingOnly(top: 4.kh),
              contentPadding: EdgeInsets.zero,
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => Get.find<MyRidesRequestController>()
                        .openMessage(element),
                    child: Container(
                      height: 24.kh,
                      width: 84.kw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.kh),
                          border: Border.all(color: ColorUtil.kSecondary01)),
                      child: Text(
                        LocaleKeys.app_message.tr,
                        style: TextStyleUtil.k12Semibold(),
                      ),
                    ),
                  ),
                  4.kheightBox,
                ],
              ),
            ),
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
            OriginToDestination(
                    origin: element.origin?.name ?? "",
                    destination: element.destination?.name ?? "",
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
                      LocaleKeys.app_rating.tr,
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
                          element.riderDetails?.rating.toString() ?? "0.0",
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
                      LocaleKeys.app_totalRides.tr,
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      element.riderDetails?.totalRides.toString() ?? "0",
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
                Column(
                  //joined in column
                  children: [
                    Text(
                      LocaleKeys.app_joined.tr,
                      style: TextStyleUtil.k12Semibold(),
                    ).paddingOnly(bottom: 4.kh),
                    Text(
                      '${LocaleKeys.app_inA.tr} ${element.riderDetails?.createdAt?.substring(0, 4) ?? 2024}',
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                  ],
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(bottom: 16.kh, top: 8.kh),
            GreenPoolButton(
              onPressed: () {
                if (element.requestSent ?? false) {
                  showMySnackbar(msg: LocaleKeys.app_reqHasAlreadySent.tr);
                } else {
                  Get.back();
                  Get.find<MyRidesRequestController>()
                      .sendRequestToRiderAPI(element);
                }
              },
              label: element.requestSent ?? false
                  ? LocaleKeys.app_sent.tr
                  : LocaleKeys.app_requestRider.tr,
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

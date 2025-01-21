import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/origin_to_destination.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';

class BookingConfirmBottom extends StatelessWidget {
  final DriverConfirmRequestModelData? driverRideData;

  BookingConfirmBottom({super.key, required this.driverRideData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.kh),
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorUtil.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.kh),
          topRight: Radius.circular(40.kh),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                LocaleKeys.app_bookingConfirmed.tr,
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(bottom: 24.kh),
            ),
            Center(
              child: SvgPicture.asset(
                ImageConstant.svgCompleteTick,
                height: 64.kh,
                width: 64.kw,
              ).paddingOnly(bottom: 16.kh),
            ),
            Center(
              child: Text(
                "${LocaleKeys.app_bookingId.tr} ${(driverRideData?.Id ?? "")}",
                textAlign: TextAlign.center,
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ),
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Text(
              LocaleKeys.app_riderDetails.tr,
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ).paddingOnly(bottom: 8.kh),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20.kh),
                      child: CommonImageView(
                        url:
                            "${driverRideData?.rideDetails?[0]?.riderDetails?[0]?.profilePic?.url}",
                      ),
                    ),
                  ),
                ).paddingOnly(right: 8.kw),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${driverRideData?.rideDetails?[0]?.riderDetails?[0]?.fullName}",
                        style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                      ).paddingOnly(bottom: 8.kh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  ImageConstant.svgIconCalendarTime,
                                  colorFilter: ColorFilter.mode(
                                    Get.find<HomeController>()
                                            .isPinkModeOn
                                            .value
                                        ? ColorUtil.kPrimary3PinkMode
                                        : ColorUtil.kSecondary01,
                                    BlendMode.srcIn,
                                  ),
                                ).paddingOnly(right: 4.kw),
                                Text(
                                  "${GpUtil.getDateFormat(driverRideData?.rideDetails?[0]?.time ?? "")}  ${GpUtil.convertUtcToLocal(driverRideData?.rideDetails?[0]?.time ?? "")}",
                                  style: TextStyleUtil.k12Regular(
                                    color: ColorUtil.kBlack02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 8.kh),
            OriginToDestination(
              origin: "${driverRideData?.rideDetails?[0]?.origin?.name}",
              destination:
                  "${driverRideData?.rideDetails?[0]?.destination?.name}",
              needPickupText: false,
            ).paddingOnly(bottom: 8.kh),
            const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 20.kh),
            GreenPoolButton(
              label: LocaleKeys.app_continueText.tr,
              onPressed: () {
                Get.back();
              },
            ),
            /*GreenPoolButton(
              label: LocaleKeys.app_cancelRequest.tr,
              isBorder: true,
              onPressed: () async {
                try {
                  final rejectRiderResponse =
                      await APIManager.patchRejectRiderRequest(
                    body: {"ridePostId": driverRideData?.Id},
                  );
                  if (rejectRiderResponse.data["status"]) {
                    Get.back();
                    showMySnackbar(msg: LocaleKeys.app_reqRejectedSuccessfully.tr);
                  } else {
                    showMySnackbar(msg: rejectRiderResponse.data["message"]);
                  }
                } catch (e) {
                  throw Exception(e);
                }
              },
            ).paddingOnly(top: 16.kh),*/
          ],
        ),
      ),
    );
  }
}

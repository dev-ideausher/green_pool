import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/image_constant.dart';
import '../modules/home/controllers/home_controller.dart';
import '../res/strings.dart';
import '../routes/app_pages.dart';
import 'colors.dart';
import 'custom_button.dart';
import 'responsive_size.dart';
import 'text_style_util.dart';

class DialogHelper {
  static void showLoading([String? message]) {
    Get.dialog(
      WillPopScope(
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Center(
                child: Container(
                    height: 80.kh,
                    width: 80.kh,
                    decoration: BoxDecoration(
                      // color: Get.context!.brandColor1,
                      color: ColorUtil.kWhiteColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0.kh),
                      ),
                    ),
                    padding: EdgeInsets.all(12.kh),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                    )),
              ),
              // message != null ? SizedBox(height: 8.kh) : const SizedBox(),
              // message != null ? Text(message) : const SizedBox(),
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.4),
      useSafeArea: true,
    );
  }

  //hide loading
  static Future<void> hideDialog() async {
    if (Get.isDialogOpen!) Get.until((route) => !Get.isDialogOpen!);
  }

  static void paymentSuccessfull() {
    Get.bottomSheet(
      isDismissible: false,
      persistent: true,
      Container(
          padding: EdgeInsets.all(24.kh),
          // height: 380.kh,
          width: 100.w,
          decoration: BoxDecoration(
              color: ColorUtil.kWhiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.kh),
                  topRight: Radius.circular(40.kh))),
          child: Column(
            children: [
              Text(
                Strings.requestSent,
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(bottom: 24.kh),
              SvgPicture.asset(
                ImageConstant.svgCompleteTick,
                height: 64.kh,
                width: 64.kw,
              ).paddingOnly(bottom: 16.kh),
              Text(
                Strings.paymentDoneRequestSentToDriver,
                textAlign: TextAlign.center,
                style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
              ).paddingOnly(bottom: 40.kh),
              GreenPoolButton(
                  label: Strings.continueText,
                  onPressed: () {
                    Get.until((route) =>
                        Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                  }),
              /*GreenPoolButton(
                label: Strings.cancelRequest,
                isBorder: true,
                onPressed: onPressedCancel,
              ).paddingOnly(top: 16.kh),*/
            ],
          )),
    );
  }

  static void cancelRideDialog(Function() onPressed) {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 212.kh,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                Strings.cancelRide,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.areYouSureYouWantToCancelThisRide,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Container(
                alignment: Alignment.centerRight,
                child: GreenPoolButton(
                  onPressed: onPressed,
                  height: 40.kh,
                  width: 144.kw,
                  label: Strings.cancelRide,
                  fontSize: 14.kh,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void deleteRecurringride(Function() onPressed) {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 212.kh,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                Strings.deleteRide,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.deleteAllUpcomingRides,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Container(
                alignment: Alignment.centerRight,
                child: GreenPoolButton(
                  onPressed: onPressed,
                  height: 40.kh,
                  width: 144.kw,
                  label: Strings.deleteRide,
                  fontSize: 14.kh,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

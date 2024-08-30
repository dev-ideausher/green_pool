import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../components/gp_progress.dart';
import '../constants/image_constant.dart';
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
        child: Center(
          child: Container(
              height: 80.kh,
              width: 80.kh,
              decoration: BoxDecoration(
                color: ColorUtil.kWhiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0.kh),
                ),
              ),
              padding: EdgeInsets.all(12.kh),
              child: const GpProgress()),
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
          height: 380.kh,
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
          height: 40.h,
          // width: 375.kw,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(40.kh),
          ),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                Strings.driverCancellationpolicy,
                style: TextStyleUtil.k24Heading700(),
                textAlign: TextAlign.center,
              ).paddingOnly(top: 14.kh, bottom: 20.kh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyleUtil.k16Medium(),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      Strings.youAreAllowedUpto6Cancellation,
                      style: TextStyleUtil.k16Medium(),
                      textAlign: TextAlign.left,
                    ).paddingOnly(bottom: 12.kh),
                  ),
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyleUtil.k16Medium(),
                    textAlign: TextAlign.left,
                  ),
                  Expanded(
                    child: Text(
                      Strings.exceedingThisMayResultSuspension,
                      style: TextStyleUtil.k16Medium(),
                      textAlign: TextAlign.left,
                    ).paddingOnly(bottom: 20.kh),
                  ),
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              GreenPoolButton(
                onPressed: onPressed,
                height: 56.kh,
                width: 343.kw,
                label: Strings.cancelRide,
                fontSize: 16.kh,
                padding: const EdgeInsets.all(8),
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }

  static void riderCancelRideDialog(Function() onPressed) {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 70.h,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(40.kh),
          ),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                Strings.riderCancellationpolicy,
                style: TextStyleUtil.k24Heading700(),
                textAlign: TextAlign.center,
              ).paddingOnly(top: 14.kh),
              16.kheightBox,
              PolicySection(
                number: '1.',
                title: Strings.withdrawalBookingReqorExpiration,
                bulletPoints: [
                  Strings.ifYouWithdrawBookingReqOrExpires,
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              PolicySection(
                number: '2.',
                title: Strings.cancellationLessThan12Hours,
                bulletPoints: [
                  Strings
                      .ifYouCancelBookingLessThan12HoursBeforeTheScheduledDeparture,
                  Strings.theDriverIsEntitledToReceiveHalfOfThePriceSeat,
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              Text(Strings.riderCancellationNote,
                      style: TextStyleUtil.k14Medium())
                  .paddingSymmetric(vertical: 8.kh, horizontal: 24.kw),
              PolicySection(
                number: '3.',
                title: Strings.cancellationMoreThan12hours,
                bulletPoints: [
                  Strings
                      .ifYouCancelBookingMoreThan12HoursBeforeScheduledDeparture,
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              PolicySection(
                number: '4.',
                title: Strings.failureToShowUp,
                bulletPoints: [
                  Strings.ifYouFailToShowUpforTheRide,
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              PolicySection(
                number: '5.',
                title: Strings.driverInitiiatedCancellation,
                bulletPoints: [
                  Strings.inTheEventThatTheDriverCancellsTheTrip,
                ],
              ).paddingSymmetric(horizontal: 24.kw),
              GreenPoolButton(
                onPressed: onPressed,
                height: 56.kh,
                width: 343.kw,
                label: Strings.cancelRide,
                fontSize: 16.kh,
                padding: const EdgeInsets.all(8),
              ).paddingOnly(top: 12.kh),
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kw),
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

  static void accSuspensionWarningDialog(Function() onPressed) {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 246.kh,
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
                Strings.accountSuspension,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.pleaseNoteYouHaveCancelledTwoRidesInPastSixMonths,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Container(
                alignment: Alignment.centerRight,
                child: GreenPoolButton(
                  onPressed: onPressed,
                  color: ColorUtil.kError2,
                  height: 40.kh,
                  width: 144.kw,
                  label: Strings.cancelRide,
                  fontSize: 14.kh,
                  labelColor: ColorUtil.kWhiteColor,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void accSuspendedDialog(Function() onPressed) {
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
                Strings.accountSuspended,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.youCannotPerformThisAction,
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
                  label: Strings.contactUs,
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

class PolicySection extends StatelessWidget {
  final String number;
  final String title;
  final List<String> bulletPoints;

  const PolicySection({
    required this.number,
    required this.title,
    required this.bulletPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: number,
              style: TextStyleUtil.k14Medium(),
              children: [
                TextSpan(
                  text: ' $title',
                  style: TextStyleUtil.k14Medium(),
                ),
              ],
            ),
          ),
          ...bulletPoints.map(
            (point) => Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyleUtil.k14Medium()),
                  Expanded(
                    child: Text(
                      point,
                      style: TextStyleUtil.k14Medium(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/pay_now_detail.dart';
import 'package:green_pool/app/data/promo_code_model.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/modules/rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import 'package:green_pool/app/services/dialog_helper.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../data/chat_arg.dart';
import '../../../data/request_ride_by_rider_model.dart';
import '../../../data/rider_confirm_request_model.dart';
import '../../../data/rider_send_request_model.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';
import '../../payment/views/insufficient_balance_bottomsheet.dart';

class PayNowController extends GetxController {
  var requestRideModel = RequestRideByRiderModel().obs;
  var riderSendRequestModelData = RiderSendRequestModelData();
  var riderConfirmRequestModelData = RiderConfirmRequestModelData();
  var promoCodeModel = PromoCodeModel().obs;
  var payNowDetail = PayNowDetail().obs;
  final RxString walletBalance = "0.0".obs;
  final RxBool isLoading = true.obs;
  final RxBool isBtnLoading = true.obs;
  final RxBool isPromoLoading = true.obs;
  final RxBool fromDriverDetails = false.obs;
  final RxBool fromConfirmRequestSection = false.obs;
  RxBool isChecked = false.obs;
  RxBool discountAvailed = false.obs;
  String ridePostId = "";
  String promoCodeId = "";
  int price = 0;
  double platformFees = 0.0;
  double discountProvided = 0.0;
  double totalAmount = 0.0;
  int pricePerSeat = 0;
  String? origin = "";
  String? stop1 = "";
  String? stop2 = "";
  String? destination = "";
  String? seatsBooked = "";
  String? promoCodeTitle = "";
  final Rx<ChatArg> chatArg = ChatArg().obs;
  bool rideCreated = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    chatArg.value = Get.arguments["chatArg"];
    rideCreated = Get.arguments["rideCreated"];
    fetchDetails(chatArg.value.driverRideId);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void fetchDetails(driverRideId) async {
    await getRideDetail(driverRideId: driverRideId);
    await getWallet();
    isLoading.value = false;
  }

  void toggleCheckbox() {
    //handles checkbox state in guidelines view
    isChecked.value = !isChecked.value;
  }

  getRideDetail({required driverRideId}) async {
    try {
      final res =
          await APIManager.getRideDetailById(driverRideId: driverRideId);
      payNowDetail.value = PayNowDetail.fromJson(res.data);
      origin = payNowDetail.value.data?.firstOrNull?.origin?.name ?? "";
      destination =
          payNowDetail.value.data?.firstOrNull?.destination?.name ?? "";
      stop1 = payNowDetail.value.data?.firstOrNull?.stops?.first?.name ?? "";
      stop2 = payNowDetail.value.data?.firstOrNull?.stops?.last?.name ?? "";
      seatsBooked =
          payNowDetail.value.data?.firstOrNull?.seatsRequired.toString() ?? "";
      price = (payNowDetail.value.data?.firstOrNull?.seatsRequired ?? 0) *
          (int.parse(payNowDetail
                  .value.data?.firstOrNull?.origin?.originDestinationFair ??
              "1"));
      platformFees = (price * 1 / 5);
      totalAmount = (price.toDouble() + platformFees);
    } catch (e) {
      debugPrint("getRideDetails error: $e");
    }
  }

  getWallet() async {
    try {
      final res = await APIManager.walletBalance();
      walletBalance.value = res.data['wallet'] ?? 0;
      walletBalance.refresh();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void decideAPI() {
    if (rideCreated) {
      //if rider has already created a ride then just needs to pay -> sendRequest api
      sendRequestToDriverAPI();
    } else {
      //if rider has not created a ride then needs to create one -> createRideAlert api
      createRideAlert();
    }
  }

  Future<void> sendRequestToDriverAPI() async {
    double totalAmountToBePaid = 0.0;
    if (discountAvailed.value) {
      totalAmountToBePaid = totalAmount + platformFees;
    } else {
      totalAmountToBePaid = totalAmount;
    }
    if (double.parse(walletBalance.value) >= totalAmountToBePaid) {
      try {
        isBtnLoading.value = true;
        final response = await APIManager.postSendRequestToDriver(body: {
          "riderRideId": chatArg.value.riderRideId,
          "driverRideId": payNowDetail.value.data?.firstOrNull?.Id,
          "driverId": payNowDetail.value.data?.firstOrNull?.driverId,
          "driverName":
              payNowDetail.value.data?.firstOrNull?.driverDetails?.fullName,
          "driverNotificationPreferences": payNowDetail
              .value.data?.firstOrNull?.driverDetails?.notificationPreferences,
          "price": price,
          "promoCodeId": promoCodeId
        });
        if (response.data['status']) {
          DialogHelper.paymentSuccessfull();          
        } else {
          showMySnackbar(msg: response.data['message'].toString());
        }
        isBtnLoading.value = false;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Get.bottomSheet(const InsufficientBalanceSheet());
    }
  }

  createRideAlert() async {
    if (payNowDetail.value.data?.firstOrNull?.ridesDetails?.date == "" ||
        payNowDetail.value.data?.firstOrNull?.ridesDetails?.date == null) {
      payNowDetail.value.data?.firstOrNull?.ridesDetails?.date =
          payNowDetail.value.data?.firstOrNull?.date;
    }
    if (payNowDetail.value.data?.firstOrNull?.ridesDetails?.time == "" ||
        payNowDetail.value.data?.firstOrNull?.ridesDetails?.time == null) {
      payNowDetail.value.data?.firstOrNull?.ridesDetails?.time =
          payNowDetail.value.data?.firstOrNull?.time;
    }
    final rideDetail = {
      "origin": {
        "name":
            payNowDetail.value.data?.firstOrNull?.ridesDetails?.origin?.name,
        "longitude": payNowDetail
            .value.data?.firstOrNull?.ridesDetails?.origin?.coordinates?.first,
        "latitude": payNowDetail
            .value.data?.firstOrNull?.ridesDetails?.origin?.coordinates?.last
      },
      "destination": {
        "name": payNowDetail
            .value.data?.firstOrNull?.ridesDetails?.destination?.name,
        "longitude": payNowDetail.value.data?.firstOrNull?.ridesDetails
            ?.destination?.coordinates?.first,
        "latitude": payNowDetail.value.data?.firstOrNull?.ridesDetails
            ?.destination?.coordinates?.last
      },
      "date": payNowDetail.value.data?.firstOrNull?.ridesDetails?.date,
      "time": payNowDetail.value.data?.firstOrNull?.ridesDetails?.time,
      "seatAvailable":
          payNowDetail.value.data?.firstOrNull?.ridesDetails?.seatAvailable,
      "description":
          payNowDetail.value.data?.firstOrNull?.ridesDetails?.description,
      "pinkMode": payNowDetail.value.data?.firstOrNull?.ridesDetails?.pinkmode,
      "price": payNowDetail.value.data?.firstOrNull?.ridesDetails?.price
    };

    double totalAmountToBePaid = 0.0;
    if (discountAvailed.value) {
      totalAmountToBePaid = totalAmount + platformFees;
    } else {
      totalAmountToBePaid = totalAmount;
    }

    if (double.parse(walletBalance.value) >= totalAmountToBePaid) {
      try {
        isBtnLoading.value = true;
        final response = await APIManager.postCreateAlert(body: {
          "ridesDetails": rideDetail,
          "driverRideId": payNowDetail.value.data?.firstOrNull?.Id,
          "distance": payNowDetail.value.data?.firstOrNull?.distance,
          "promoCodeId": promoCodeId
        });
        requestRideModel.value =
            RequestRideByRiderModel.fromJson(response.data);
        if (requestRideModel.value.status ?? false) {
          DialogHelper.paymentSuccessfull();
        } else {
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
        isBtnLoading.value = false;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      Get.bottomSheet(const InsufficientBalanceSheet());
    }
  }

  promoCodeAPI() async {
    try {
      isPromoLoading.value = true;
      final response = await APIManager.getPromoCode();
      var data = jsonDecode(response.toString());
      promoCodeModel.value = PromoCodeModel.fromJson(data);
      isPromoLoading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  applyDiscount(index) {
    isLoading.value = true;
    if (price >= promoCodeModel.value.data![index]!.minAmount!.toInt()) {
      //if price meets minAmnt criteria then apply type of discount accordingly
      discountAvailed.value = true;
      promoCodeTitle = promoCodeModel.value.data![index]!.promoCode;
      if (promoCodeModel.value.data![index]!.discountCodeType == "%") {
        final double discountPercent =
            promoCodeModel.value.data![index]!.discountAmount!;

        final double discountAmount =
            double.parse((price * discountPercent / 100).toStringAsFixed(2));

        discountProvided = discountAmount;

        final double discountedPrice = price - discountAmount;

        totalAmount = discountedPrice;
      } else {
        final double? discount =
            promoCodeModel.value.data![index]!.discountAmount;
        discountProvided = discount!;
        totalAmount = price - discount;
      }
      promoCodeId = promoCodeModel.value.data?[index]?.Id ?? "";
      isLoading.value = false;
      Get.back();
    } else {
      //if price does not meet minAmnt criteria
      isLoading.value = false;
      promoCodeId = "";
      discountAvailed.value = false;
      totalAmount = price + platformFees;
      discountAvailed.refresh();
      showMySnackbar(
          msg:
              "The minimum ride amount to avail this offer is \$${promoCodeModel.value.data![index]!.minAmount!}");
    }
  }

  void moveToWallet() {
    Get.toNamed(Routes.WALLET);
  }

  getDriverPolicy() {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 35.h,
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
                    ).paddingOnly(bottom: 12.kh),
                  ),
                ],
              ).paddingSymmetric(horizontal: 24.kw),
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }

  getRiderPolicy() {
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
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

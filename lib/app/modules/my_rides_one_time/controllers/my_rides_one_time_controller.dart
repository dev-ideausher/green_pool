import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/recurring_rides_model.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';

class MyRidesOneTimeController extends GetxController {
  RxString ridePostId = ''.obs;
  final RxList<MyRidesModelData> myRidesModelData = <MyRidesModelData>[].obs;
  var confirmRequestModel = DriverConfirmRequestModel().obs;
  final RxBool isLoad = true.obs;
  var recurringResp = RecurringRidesModel().obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await myRidesAPI();

    isLoad.value = false;
  }

  myRidesAPI({bool isRecurring = false}) async {
    try {
      isLoad.value = true;
      final response = await APIManager.getAllMyRides();
      final mData = MyRidesModel.fromJson(response.data);
      myRidesModelData.value = mData.data!
          .where((element) => !(element.isCancelled ?? false))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
    }
    if (isRecurring) {
      await allRecurringRidesAPI();
    }
    isLoad.value = false;
  }

  riderCancelRideAPI(MyRidesModelData myRidesModelData) async {
    final Map<String, dynamic> riderRideId = {
      "riderRideId": myRidesModelData.Id
    };
    try {
      isLoad.value = true;
      final cancelRideResponse =
          await APIManager.riderCancelRide(body: riderRideId);
      var data = jsonDecode(cancelRideResponse.toString());
      await myRidesAPI();
      isLoad.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  cancelRideAPI(MyRidesModelData myRidesModelData) async {
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
                Strings.delete,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                Strings.areYouSureYouWantToDeleteThisRide,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Container(
                alignment: Alignment.centerRight,
                child: GreenPoolButton(
                  onPressed: () async {
                    Get.back();
                    final Map<String, dynamic> driverRideId = {
                      "driverRideId": myRidesModelData.Id,
                    };
                    try {
                      isLoad.value = true;
                      final cancelRideResponse =
                          await APIManager.cancelRide(body: driverRideId);
                      var data = jsonDecode(cancelRideResponse.toString());
                      await myRidesAPI();
                      isLoad.value = false;
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  height: 40.kh,
                  width: 144.kw,
                  label: Strings.delete,
                  fontSize: 14.kh,
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // Get.defaultDialog(
    //   title: Strings.deleteRide
    //   content: Text(Strings.areYouSureYouWantToDeleteThisRide),
    //   actions: [
    //     TextButton(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       child: Text(
    //         Strings.cancel,
    //         style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack03),
    //       ),
    //     ),
    //     ElevatedButton(
    //       onPressed: () async {
    //         Get.back();
    //         final Map<String, dynamic> driverRideId = {
    //           "driverRideId": myRidesModelData.Id,
    //         };
    //         try {
    //           isLoad.value = true;
    //           final cancelRideResponse = await APIManager.cancelRide(body: driverRideId);
    //           var data = jsonDecode(cancelRideResponse.toString());
    //           await myRidesAPI();
    //           isLoad.value = false;
    //         } catch (e) {
    //           debugPrint(e.toString());
    //         }
    //       },
    //       child: Text(Strings.delete, style: TextStyleUtil.k14Bold(color: ColorUtil.kError4)),
    //     ),
    //   ],
    // );
  }

  void viewDetails(MyRidesModelData myRidesModelData) {
    if (myRidesModelData.postsInfo!.isNotEmpty) {
      Get.toNamed(Routes.MY_RIDES_DETAILS,
              arguments: myRidesModelData.postsInfo?.first?.driverRideId)
          ?.then((v) => myRidesAPI());
    } else {
      openMyRideDetail(myRidesModelData);
    }
  }

  void riderPagePageOpen(MyRidesModelData myRidesModelData) {
    if (myRidesModelData.confirmDriverDetails!.isEmpty) {
      if (myRidesModelData.rideStatus == "Confirmed") {
        Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
                arguments: myRidesModelData)
            ?.then((v) => myRidesAPI);
        ;
      } else {
        Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
                arguments: myRidesModelData.Id)
            ?.then((v) => myRidesAPI);
        ;
      }
    } else {
      if (myRidesModelData.confirmDriverDetails?.first?.driverPostsDetails
              ?.first?.isStarted ??
          false) {
        Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: myRidesModelData)
            ?.then((v) => myRidesAPI);
        ;
      } else {
        if (myRidesModelData.rideStatus == "Confirmed") {
          Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
                  arguments: myRidesModelData)
              ?.then((v) => myRidesAPI);
          ;
        } else {
          Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
                  arguments: myRidesModelData.Id)
              ?.then((v) => myRidesAPI);
          ;
        }
      }
    }
  }

  void startRide(MyRidesModelData value) {
    if (value.postsInfo?.isEmpty ?? false) {
      openMyRideDetail(value);
    } else {
      if (value.postsInfo!.isNotEmpty) {
        Get.toNamed(Routes.START_RIDE,
                arguments: value.postsInfo?[0].driverRideId)
            ?.then((v) => myRidesAPI);
        ;
      } else {
        showMySnackbar(msg: "You have no riders at the moment");
      }
    }
  }

  void openMyRideDetail(MyRidesModelData myRidesModelData) {
    Get.toNamed(Routes.MY_RIDES_DETAILS,
        arguments: BookingDetailModelData(
            driverRideId: myRidesModelData.Id,
            driverBookingDetails: BookingDetailModelDataDriverBookingDetails(
              origin: BookingDetailModelDataDriverBookingDetailsOrigin(
                  coordinates: myRidesModelData.origin!.coordinates,
                  name: myRidesModelData.origin!.name,
                  originDestinationFair:
                      myRidesModelData.origin?.originDestinationFair,
                  type: myRidesModelData.origin!.type),
              destination:
                  BookingDetailModelDataDriverBookingDetailsDestination(
                      coordinates: myRidesModelData.destination!.coordinates,
                      name: myRidesModelData.destination!.name,
                      type: myRidesModelData.destination!.type),
              date: myRidesModelData.date,
              time: myRidesModelData.time,
              description: myRidesModelData.description,
              preferences: BookingDetailModelDataDriverBookingDetailsPreferences(
                  other:
                      BookingDetailModelDataDriverBookingDetailsPreferencesOther(
                          AppreciatesConversation: myRidesModelData
                              .preferences?.other?.AppreciatesConversation,
                          BabySeat:
                              myRidesModelData.preferences?.other?.BabySeat,
                          CoolingOrHeating: myRidesModelData
                              .preferences?.other?.CoolingOrHeating,
                          EnjoysMusic:
                              myRidesModelData.preferences?.other?.EnjoysMusic,
                          HeatedSeats:
                              myRidesModelData.preferences?.other?.HeatedSeats,
                          PetFriendly:
                              myRidesModelData.preferences?.other?.PetFriendly,
                          SmokeFree:
                              myRidesModelData.preferences?.other?.SmokeFree,
                          WinterTires: myRidesModelData
                              .preferences?.other?.WinterTires)),
            ),
            driverDetails: BookingDetailModelDataDriverDetails(
              vehicleDetails: BookingDetailModelDataDriverDetailsVehicleDetails(
                model: myRidesModelData.vehicleDetails?[0]?.model,
                licencePlate: myRidesModelData.vehicleDetails?[0]?.licencePlate,
                vehiclePic:
                    BookingDetailModelDataDriverDetailsVehicleDetailsVehiclePic(
                  url: myRidesModelData.vehicleDetails?[0]?.vehiclePic?.url,
                ),
                type: myRidesModelData.vehicleDetails?[0]?.type,
              ),
            )))?.then((v) => myRidesAPI());
  }

  allRecurringRidesAPI() async {
    try {
      final response = await APIManager.getAllRecurringRides();
      var data = jsonDecode(response.toString());
      recurringResp.value = RecurringRidesModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  enableRecurringAPI(input) async {
    final driverRideId = input;
    try {
      final response =
          await APIManager.enableDisableRecurring(driverRIdeId: driverRideId);
      var data = jsonDecode(response.toString());
      await allRecurringRidesAPI();

      print(data.toString());
    } catch (e) {
      throw Exception(e);
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dialog_helper.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/booking_detail_model.dart';
import '../../../data/recurring_rides_model.dart';
import '../../../data/ride_detail_id.dart';
import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';

class MyRidesOneTimeController extends GetxController {
  RxString ridePostId = ''.obs;
  final RxList<MyRidesModelData> myRidesModelData = <MyRidesModelData>[].obs;
  final RxList<MyRidesModelData> driverRides = <MyRidesModelData>[].obs;
  final RxList<MyRidesModelData> riderRides = <MyRidesModelData>[].obs;
  final Rx<BookingDetailModelData> rideBookingData =
      BookingDetailModelData().obs;
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
      driverRides.value =
          myRidesModelData.where((item) => (item.driverId != null)).toList();
      riderRides.value =
          myRidesModelData.where((item) => (item.riderId != null)).toList();
      await allRecurringRidesAPI();
    } catch (e) {
      debugPrint(e.toString());
    }
    // if (isRecurring) {
    //   await allRecurringRidesAPI();
    // }
    isLoad.value = false;
  }

  riderCancelRideAPI(MyRidesModelData myRidesModelData) async {
    DialogHelper.cancelRideDialog(() async {
      Get.back();
      final Map<String, dynamic> riderRideId = {
        "riderRideId": myRidesModelData.Id
      };
      try {
        isLoad.value = true;
        final cancelRideResponse =
            await APIManager.riderCancelRide(body: riderRideId);
        if (cancelRideResponse.data['status']) {
          await myRidesAPI();
          Get.back();
        } else {
          showMySnackbar(msg: cancelRideResponse.data['message'].toString());
        }
        isLoad.value = false;
      } catch (e) {
        throw Exception(e);
      }
    });
  }

  cancelRideAPI(MyRidesModelData myRidesModelData) async {
    DialogHelper.cancelRideDialog(
      () async {
        Get.back();
        final Map<String, dynamic> driverRideId = {
          "driverRideId": myRidesModelData.Id,
        };
        try {
          isLoad.value = true;
          final cancelRideResponse =
              await APIManager.cancelRide(body: driverRideId);
          if (cancelRideResponse.data['status']) {
            await myRidesAPI();
          } else {
            showMySnackbar(msg: cancelRideResponse.data['message'].toString());
          }
          isLoad.value = false;
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
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
      } else {
        Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
                arguments: myRidesModelData.Id)
            ?.then((v) => myRidesAPI);
      }
    } else {
      if (myRidesModelData.confirmDriverDetails?.first?.driverPostsDetails
              ?.first?.isStarted ??
          false) {
        Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: myRidesModelData)
            ?.then((v) => myRidesAPI);
      } else {
        if (myRidesModelData.rideStatus == "Confirmed") {
          Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
                  arguments: myRidesModelData)
              ?.then((v) => myRidesAPI);
        } else {
          Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
                  arguments: myRidesModelData.Id)
              ?.then((v) => myRidesAPI);
        }
      }
    }
  }

  Future<void> startRide(MyRidesModelData value) async {
    if (value.postsInfo?.isEmpty ?? false) {
      // openMyRideDetail(value);
      moveToRequests(value).then((v) => myRidesAPI);
    } else {
      if (value.postsInfo!.isNotEmpty) {
        Get.toNamed(Routes.START_RIDE,
                arguments: value.postsInfo?[0]?.driverRideId)
            ?.then((v) => myRidesAPI);
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

  Future<void> moveToRequests(MyRidesModelData value) async {
    await Get.toNamed(Routes.MY_RIDES_REQUEST,
            arguments: RideDetailId(
                driverRidId: value?.Id ?? "",
                // riderRidId: myRidesModelData.value.riderRideId ?? ""
                riderRidId: ""))
        ?.then((v) => myRidesAPI);
  }

  void deleteRecurringride(String id) {
    DialogHelper.deleteRecurringride(
      () async {
        Get.back();
        try {
          isLoad.value = true;
          final res = await APIManager.deleteRecurringRide(rideId: id);
          if (res.data['status']) {
            showMySnackbar(msg: "Ride deleted successfully!");
            await myRidesAPI();
          } else {
            showMySnackbar(msg: res.data['message'].toString());
          }
          isLoad.value = false;
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  bool decideNoRidesVisibilty(String? type) {
    bool isNoRidesVisible = false;
    if (type == null) {
      if (driverRides.isEmpty &&
          riderRides.isEmpty &&
          (recurringResp.value.data?.isEmpty ?? true)) {
        return isNoRidesVisible = true;
      } else {
        return isNoRidesVisible = false;
      }
    } else if (type == Strings.booked) {
      if (driverRides.isEmpty) {
        return isNoRidesVisible = true;
      } else {
        return isNoRidesVisible = false;
      }
    } else if (type == Strings.published) {
      if (riderRides.isEmpty) {
        return isNoRidesVisible = true;
      } else {
        return isNoRidesVisible = false;
      }
    }
    return isNoRidesVisible;
  }
}

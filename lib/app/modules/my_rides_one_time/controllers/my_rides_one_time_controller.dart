import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pool/app/data/driver_cofirm_request_model.dart';

import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../data/booking_detail_model.dart';
import '../../../routes/app_pages.dart';

class MyRidesOneTimeController extends GetxController {
  RxString ridePostId = ''.obs;
  final RxList<MyRidesModelData> myRidesModelData = <MyRidesModelData>[].obs;
  var confirmRequestModel = DriverConfirmRequestModel().obs;
  final RxBool isLoad = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  Future<void> onReady() async {
    super.onReady();
    await myRidesAPI();
    isLoad.value = false;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  myRidesAPI() async {
    try {
      isLoad.value = true;
      final response = await APIManager.getAllMyRides();
      var data = jsonDecode(response.toString());
      final mData = MyRidesModel.fromJson(data);
      myRidesModelData.value = mData.data!
          .where((element) => !(element.isCancelled ?? false))
          .toList();
      isLoad.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  riderCancelRideAPI(MyRidesModelData myRidesModelData) async {
    final Map<String, dynamic> riderRideId = {
      "riderRideId": myRidesModelData.Id,
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
      throw Exception(e);
    }
  }

  void viewDetails(MyRidesModelData myRidesModelData) {
    /*  if (myRidesModelData.confirmDriverDetails?.first?.driverPostsDetails?.first?.isStarted ?? false) {
      Get.toNamed(Routes.START_RIDE, arguments: myRidesModelData);
    } else {*/

    /*  }*/
    if (myRidesModelData.postsInfo!.isNotEmpty) {
      Get.toNamed(Routes.MY_RIDES_DETAILS,
          arguments: myRidesModelData.postsInfo?.first?.Id);
    } else {
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
                            EnjoysMusic: myRidesModelData
                                .preferences?.other?.EnjoysMusic,
                            HeatedSeats: myRidesModelData
                                .preferences?.other?.HeatedSeats,
                            PetFriendly: myRidesModelData
                                .preferences?.other?.PetFriendly,
                            SmokeFree:
                                myRidesModelData.preferences?.other?.SmokeFree,
                            WinterTires: myRidesModelData
                                .preferences?.other?.WinterTires)),
                driverDetails:
                    BookingDetailModelDataDriverBookingDetailsDriverDetails(
                        vechileDetails:
                            BookingDetailModelDataDriverBookingDetailsDriverDetailsVechileDetails(
                  model: myRidesModelData.vehicleDetails?[0]?.model,
                  licencePlate:
                      myRidesModelData.vehicleDetails?[0]?.licencePlate,
                  vehiclePic:
                      BookingDetailModelDataDriverBookingDetailsDriverDetailsVechileDetailsVehiclePic(
                    url: myRidesModelData.vehicleDetails?[0]?.vehiclePic?.url,
                  ),
                  type: myRidesModelData.vehicleDetails?[0]?.type,
                )),
              )));
    }
  }

  void riderPagePageOpen(MyRidesModelData myRidesModelData) {
    if (myRidesModelData.confirmDriverDetails!.isEmpty) {
      if (myRidesModelData.rideStatus == "Confirmed") {
        Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
            arguments: myRidesModelData);
      } else {
        Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
            arguments: myRidesModelData.Id);
      }
    } else {
      if (myRidesModelData.confirmDriverDetails?.first?.driverPostsDetails
              ?.first?.isStarted ??
          false) {
        Get.toNamed(Routes.RIDER_START_RIDE_MAP, arguments: myRidesModelData);
      } else {
        if (myRidesModelData.rideStatus == "Confirmed") {
          Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
              arguments: myRidesModelData);
        } else {
          Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
              arguments: myRidesModelData.Id);
        }
      }
    }
  }

  void startRide(MyRidesModelData value) {
    if (value.postsInfo!.isNotEmpty) {
      Get.toNamed(Routes.START_RIDE, arguments: value.postsInfo?[0]?.Id);
    } else {
      showMySnackbar(msg: "You have no riders at the moment");
    }
  }
}

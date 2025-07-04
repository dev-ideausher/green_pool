import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/modules/ride_invite_screen/models/ride_invite_model.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/chat_arg.dart';
import '../../../data/find_ride_model.dart';
import '../../../data/matching_rides_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/gp_util.dart';
import '../../home/controllers/home_controller.dart';

class RideInviteScreenController extends GetxController {
  RxBool isLoading = false.obs;
  var rideInviteData = RideInviteData().obs;
  RxBool messageBtnLoading = false.obs;
  String driverRideId = "";
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  int distance = 0;

  @override
  void onInit() {
    super.onInit();
    driverRideId = Get.arguments['driverRideId'];
    distance = getDistance();
  }

  @override
  void onReady() {
    super.onReady();
    _getRideDetails();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _getRideDetails() async {
    try {
      isLoading.value = true;
      final resp =
          await APIManager.getRideDetailById(driverRideId: driverRideId);

      if (resp.data['status']) {
        rideInviteData.value = RideInviteData.fromJson(resp.data['data'][0]);

        //check if the date of the ride is before today or before the time that is today then give error and get back to nav bar
        final rideDateTimeString = DateTimeUtils.dateUtcToLocal(
            rideInviteData.value.date ?? LocaleKeys.app_defaultDate.tr);
        final rideDateTime = DateTime.parse(rideDateTimeString);

        /*if (rideDateTime != null) { //TODO: check if this is needed
          final now = DateTime.now();

          if (rideDateTime.isBefore(now)) {
            // Ride is in the past → show error + go back
            showMySnackbar(msg: LocaleKeys.app_thisRideHasAlreadyExpired.tr);

            // Go back to main navigation or wherever needed
            Get.until((route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
            return;
          }
        }*/

        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  void toPrevRides(RideInviteDataDriverDetails? driverDetails) {
    Get.toNamed(Routes.PREVIOUS_RIDES, arguments: {
      "driverName": driverDetails?.fullName,
      "driverId": driverDetails?.Id
    });
  }

  isUserLoggedIn(String value) {
    final rideDetails = _setRideDetailsFindRideModel();

    if (Get.find<GetStorageService>().isLoggedIn) {
      if (Get.find<GetStorageService>().profileStatus == true) {
        if (value == "chat") {
          chatWithDriver();
        } else {
          moveToPayment();
        }
      } else {
        Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
          "fromNavBar": false,
          "fullName": Get.find<GetStorageService>().getUserName,
          "findRideModel": rideDetails
        });
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: {
        'isDriver': false,
        'fromNavBar': false,
        'findRideModel': rideDetails
      });
    }
  }

  Future<void> chatWithDriver() async {
    try {
      messageBtnLoading.value = true;
      final rideDetails = _setRideDetails();
      final res = await APIManager.postChatRoomId(
          receiverId: rideInviteData.value.driverDetails?.Id ?? "",
          body: {
            "driverRideId": driverRideId,
            "seatsRequired": rideDetails['ridesDetails']!["seatAvailable"],
            "riderRideId": "",
            "ridesDetails": rideDetails['ridesDetails'],
            "distance": distance
          });

      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: rideInviteData.value.driverDetails?.Id,
              driverRideId: driverRideId,
              name: rideInviteData.value.driverDetails?.fullName,
              image: rideInviteData.value.driverDetails?.profilePic?.url,
              origin:
                  rideInviteData.value.origin?.name?.split(',').first ?? "City",
              destination:
                  rideInviteData.value.destination?.name?.split(',').first ??
                      "City",
              date: DateTimeUtils.formatDate(DateTime.parse(
                  rideInviteData.value.date ??
                      LocaleKeys.app_defaultDate.tr))));
      messageBtnLoading.value = false;
    } catch (e) {
      try {
        Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
                chatRoomId: "",
                id: rideInviteData.value.driverDetails?.Id ?? "",
                deleteUpdateTime: "",
                driverRideId: driverRideId,
                name: rideInviteData.value.driverDetails?.fullName ?? "",
                image: rideInviteData.value.driverDetails?.profilePic?.url,
                origin: rideInviteData.value.origin?.name?.split(',').first ??
                    "City",
                destination:
                    rideInviteData.value.destination?.name?.split(',').first ??
                        "City",
                date: DateTimeUtils.formatDate(DateTime.parse(
                    rideInviteData.value.date ??
                        LocaleKeys.app_defaultDate.tr))));
        messageBtnLoading.value = false;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  moveToPayment() async {
    final rideDetails = _setRideDetails();

    final Map<String, dynamic> rideData = {
      "ridesDetails": rideDetails["ridesDetails"],
      "driverRideId": driverRideId,
      "distance": distance,
    };

    final pricePerSeat =
        int.parse(rideInviteData.value.origin?.originDestinationFair ?? "0");

    rideData["ridesDetails"]["price"] = pricePerSeat;
    debugPrint(rideData["ridesDetails"]["price"].toString());

    Get.toNamed(Routes.PAYMENT,
        arguments: {"rideData": rideData, "pricePerSeat": pricePerSeat});
  }

  FindRideModel _setRideDetailsFindRideModel() {
    return FindRideModel(
      ridesDetails: FindRideModelRidesDetails(
        date: rideInviteData.value.date?.split("T").first,
        seatAvailable: 1,
        time: rideInviteData.value.date,
        description: "",
        pinkMode: Get.find<GetStorageService>().isPinkMode,
        origin: FindRideModelRidesDetailsOrigin(
          latitude: rideInviteData.value.origin?.coordinates?.last,
          longitude: rideInviteData.value.origin?.coordinates?.first,
          name: rideInviteData.value.origin?.name,
        ),
        destination: FindRideModelRidesDetailsDestination(
          latitude: rideInviteData.value.destination?.coordinates?.last,
          longitude: rideInviteData.value.destination?.coordinates?.first,
          name: rideInviteData.value.destination?.name,
        ),
      ),
    );
  }

  Map<String, dynamic> _setRideDetails() {
    return {
      'ridesDetails': {
        'date': rideInviteData.value.date?.split("T").first,
        'seatAvailable': 1,
        'time': rideInviteData.value.date,
        'description': '',
        'pinkMode': Get.find<GetStorageService>().isPinkMode,
        'origin': {
          'latitude': rideInviteData.value.origin?.coordinates?.last,
          'longitude': rideInviteData.value.origin?.coordinates?.first,
          'name': rideInviteData.value.origin?.name,
        },
        'destination': {
          'latitude': rideInviteData.value.destination?.coordinates?.last,
          'longitude': rideInviteData.value.destination?.coordinates?.first,
          'name': rideInviteData.value.destination?.name,
        },
      },
    };
  }

  int getDistance() {
    return GpUtil.calculateDistance(
        startLat: rideInviteData.value.origin?.coordinates?.last ?? latitude,
        startLong: rideInviteData.value.origin?.coordinates?.first ?? longitude,
        endLat: rideInviteData.value.destination?.coordinates?.last ?? latitude,
        endLong:
            rideInviteData.value.destination?.coordinates?.first ?? longitude);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/booking_detail_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../services/dio/api_service.dart';
import '../model/prev_rides_model.dart';

class PrevPostedController extends GetxController {
  final Rx<PrevRides> prevRides = PrevRides().obs;
  RxBool isLoading = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _fetchRides();
  }

  @override
  void onClose() {
    super.onClose();
  }

  _fetchRides() async {
    try {
      final response = await APIManager.getPrevPostedRides();
      if (response.data['status'] == "success") {
        prevRides.value = PrevRides.fromJson(response.data);
      } else {
        debugPrint("Error in getting prev rides");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  void increment() => count.value++;

  void toEditRide(PrevRidesDataData? data) {
    final otherPrefs = data?.preferences?.other;
    final isRecRide = data?.isRecurring ?? false;
    final recInst = data?.recurringInstances?[0];
    final recOtherPref = recInst?.preferences?.other;

    Get.toNamed(Routes.MY_RIDES_EDIT,
        arguments: BookingDetailModelData(
            isCompleted: data?.isCompleted ?? false,
            driverId: data?.driverId ?? "",
            createdAt: data?.createdAt ?? "",
            updatedAt: data?.updatedAt ?? "",
            driverBookingDetails: BookingDetailModelDataDriverBookingDetails(
              origin: BookingDetailModelDataDriverBookingDetailsOrigin(
                  name: data?.origin?.name ?? "",
                  type: data?.origin?.type ?? "",
                  originDestinationFair:
                      data?.origin?.originDestinationFair ?? "",
                  coordinates: data?.origin?.coordinates ?? []),
              destination:
                  BookingDetailModelDataDriverBookingDetailsDestination(
                      name: data?.destination?.name ?? "",
                      type: data?.destination?.type ?? "",
                      coordinates: data?.destination?.coordinates ?? []),
              stops: data?.stops
                  ?.map((e) => BookingDetailModelDataDriverBookingDetailsStops(
                      name: e?.name ?? "",
                      type: e?.type ?? "",
                      coordinates: [
                        e?.coordinates?.last ?? 0,
                        e?.coordinates?.first ?? 0
                      ],
                      originToStopFair: e?.originToStopFair ?? "",
                      stopToStopFair: e?.stopToStopFair ?? "",
                      stopTodestinationFair: e?.stopTodestinationFair ?? ""))
                  .toList(),
              tripType: data?.tripType ?? "",
              time: isRecRide ? (recInst?.time ?? "") : (data?.time ?? ""),
              date: isRecRide
                  ? (recInst?.date ?? LocaleKeys.app_defaultDate.tr)
                  : (data?.date ?? LocaleKeys.app_defaultDate.tr),
              recurringTrip:
                  BookingDetailModelDataDriverBookingDetailsRecurringTrip(
                      recurringTripDays:
                          data?.recurringTrip?.recurringTripDays ?? [],
                      recurringTripIds:
                          data?.recurringTrip?.recurringTripIds ?? [],
                      isRecurringTripEnabled:
                          data?.recurringTrip?.isRecurringTripEnabled ?? false),
              returnTrip: BookingDetailModelDataDriverBookingDetailsReturnTrip(
                  isReturnTrip: data?.returnTrip?.isReturnTrip ?? false,
                  returnDate: data?.returnTrip?.returnDate ?? "",
                  returnTime: data?.returnTrip?.returnTime ?? ""),
              seatAvailable: isRecRide
                  ? (recInst?.seatAvailable ?? 1)
                  : (data?.seatAvailable ?? 1),
              preferences: BookingDetailModelDataDriverBookingDetailsPreferences(
                  luggageType: data?.preferences?.luggageType ?? "",
                  other:
                      BookingDetailModelDataDriverBookingDetailsPreferencesOther(
                          AppreciatesConversation: isRecRide
                              ? (recOtherPref?.AppreciatesConversation)
                              : (otherPrefs?.AppreciatesConversation ?? false),
                          EnjoysMusic: isRecRide
                              ? (recOtherPref?.EnjoysMusic)
                              : (otherPrefs?.EnjoysMusic ?? false),
                          SmokeFree: isRecRide
                              ? (recOtherPref?.SmokeFree)
                              : (otherPrefs?.SmokeFree ?? false),
                          PetFriendly: isRecRide
                              ? (recOtherPref?.PetFriendly)
                              : (otherPrefs?.PetFriendly ?? false),
                          WinterTires: isRecRide
                              ? (recOtherPref?.WinterTires)
                              : (otherPrefs?.WinterTires ?? false),
                          CoolingOrHeating: isRecRide
                              ? (recOtherPref?.CoolingOrHeating)
                              : (otherPrefs?.CoolingOrHeating ?? false),
                          BabySeat: isRecRide
                              ? (recOtherPref?.BabySeat)
                              : (otherPrefs?.BabySeat ?? false),
                          HeatedSeats: isRecRide
                              ? (recOtherPref?.HeatedSeats)
                              : (otherPrefs?.HeatedSeats ?? false))),
              arrivalDate: data?.arrivalDate ?? "",
              arrivalTime: data?.arrivalTime ?? "",
              isStarted: data?.isStarted ?? false,
              isCompleted: data?.isCompleted ?? false,
              isCancelled: data?.isCancelled ?? false,
            )));
  }
}

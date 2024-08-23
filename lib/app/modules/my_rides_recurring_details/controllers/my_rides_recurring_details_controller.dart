import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/recurring_ride_details_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:intl/intl.dart';

class MyRidesRecurringDetailsController extends GetxController {
  int numberOfDays = 7;
  String rideId = "";
  var recurringModel = RecurringRideDetailsModel().obs;
  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    rideId = Get.arguments;
    await recurringRideDetailsAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  recurringRideDetailsAPI() async {
    try {
      isLoading.value = true;
      final String driverRideId = "/$rideId";
      final response =
          await APIManager.getRecurringRideDetails(rideId: driverRideId);
      recurringModel.value = RecurringRideDetailsModel.fromJson(response.data);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    }
  }

  static String formatDate(DateTime timestamp) {
    final localTimestamp = timestamp.toLocal(); // Convert to local time zone

    // Format the day with suffix (e.g., 4th, 21st, 22nd)
    String getDayWithSuffix(int day) {
      if (day >= 11 && day <= 13) {
        return '${day}th';
      }
      switch (day % 10) {
        case 1:
          return '${day}st';
        case 2:
          return '${day}nd';
        case 3:
          return '${day}rd';
        default:
          return '${day}th';
      }
    }

    // Get the formatted date parts
    final dayName = DateFormat('E').format(localTimestamp); // Monday
    final day = getDayWithSuffix(localTimestamp.day); // 4th
    final month = DateFormat('MMM').format(localTimestamp); // March

    return '$dayName $day $month';
  }

  getDateFormat(String dateTime) {
    var outputDate = "";
    if (dateTime != "") {
      try {
        var combinedDateUtc = GpUtil.convertCombinedUtcToLocal(dateTime);
        outputDate =
            formatDate(DateTime.parse(combinedDateUtc.split("T").first))
                .toString();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return outputDate;
  }
}

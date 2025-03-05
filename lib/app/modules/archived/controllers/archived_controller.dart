import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/archived_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';
import '../../../services/utils/date_utils.dart';

class ArchivedController extends GetxController {
  RxBool refreshPage = true.obs;
  RxBool isLoading = false.obs;
  final Rx<ArchivedModel> archivedModel = ArchivedModel().obs;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    super.onInit();
    showLoadingMessages();
  }

  Future<void> showLoadingMessages() async {
    isLoading.value = true;
    await getArchivedListAPI();
    isLoading.value = false;
  }

  getArchivedListAPI() async {
    try {
      final resp = await APIManager.getArchivedChatList();
      var data = jsonDecode(resp.toString());
      archivedModel.value = ArchivedModel.fromJson(data);
      archivedModel.refresh();
      /*archivedModel.value.chatRoomIds?.sort((a, b) {
        final dateTimeA =
            DateTime.parse(a!.updatedAt ?? "2024-01-01T00:00:00.000Z");
        final dateTimeB =
            DateTime.parse(b!.updatedAt ?? "2024-01-01T00:00:00.000Z");

        if (dateTimeA == null && dateTimeB == null) {
          return 0;
        } else if (dateTimeA == null) {
          return 1;
        } else if (dateTimeB == null) {
          return -1;
        } else {
          return dateTimeB.compareTo(dateTimeA);
        }
      });*/
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getToChatPage(
      message, GlobalKey<RefreshIndicatorState> refreshIndicatorKey) async {
    Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
              chatRoomId: message?.chatRoomId ?? "",
              id: message?.reciver?.Id ?? "",
              driverRideId: message.driverRideDetails?.Id ?? "",
              riderRideId: message.riderRideId ?? "",
              image: message?.reciver?.profilePic?.url,
              deleteUpdateTime: message?.deleteUpdateTime ?? "",
              name: message?.reciver?.fullName,
              origin: message?.driverRideDetails?.origin?.split(",").first,
              destination:
                  message?.driverRideDetails?.destination?.split(",").first,
              date: DateTimeUtils.formatDate(DateTime.parse(
                  message?.driverRideDetails?.date ??
                      LocaleKeys.app_defaultDate.tr)),
            ))!
        .then((value) async {
      if (value != true) {
        Future.delayed(const Duration(milliseconds: 100), () {
          refreshIndicatorKey.currentState?.show();
        });
        archivedModel.refresh();
      } else {
        showLoadingMessages();
      }
    });
  }

  Future<void> unarchiveChat(String chatRoomId) async {
    try {
      final res = await APIManager.patchUnarchiveMsg(chatRoomId: chatRoomId);
      if (res.statusCode == 200) {
        getArchivedListAPI();
      } else {
        showMySnackbar(msg: "Oops! Something went wrong");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

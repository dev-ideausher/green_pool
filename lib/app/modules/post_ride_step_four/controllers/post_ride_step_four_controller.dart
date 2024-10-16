import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../res/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';

class PostRideStepFourController extends GetxController {
  RxBool isChecked = false.obs;
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    postRideModel.value = Get.arguments;
  }

  void toggleCheckbox() {
    //handles checkbox state in guidelines view
    isChecked.value = !isChecked.value;
  }

  void setGuideLines() {
    //handles button state in guidelines view
    if (isChecked.value == true) {
      try {
        postRideAPI();
      } catch (e) {
        throw Exception(e);
      }
    } else {
      showMySnackbar(msg: 'Terms and Conditions not accepted');
    }
  }

  postRideAPI() async {
    try {
      final postRideDataJson = postRideModel.value.toJson();
      final res = await APIManager.postDriverPostRide(body: postRideDataJson);

      if (res.data['status']) {
        showMySnackbar(msg: "Ride posted successfully");
        await Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        showMySnackbar(msg: res.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
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
                    ).paddingOnly(bottom: 20.kh),
                  ),
                ],
              ).paddingSymmetric(horizontal: 24.kw),
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

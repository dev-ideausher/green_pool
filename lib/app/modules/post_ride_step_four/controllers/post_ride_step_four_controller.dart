import 'package:get/get.dart';
import 'package:green_pool/app/data/post_ride_model.dart';

import '../../../routes/app_pages.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';

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
      await APIManager.postDriverPostRide(body: postRideDataJson);
      showMySnackbar(msg: "Ride posted successfully");
      await Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
    } catch (e) {
      throw Exception(e);
    }
  }
}

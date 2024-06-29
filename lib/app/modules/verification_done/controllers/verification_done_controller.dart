import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';

class VerificationDoneController extends GetxController {
  bool fromNavBar = false;
  bool isDriver = false;
  String fullName = "";
  final confettiController = ConfettiController();
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
        fullName = Get.arguments['fullName'];
      } else {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
        fullName = Get.arguments['fullName'];
      }
    } catch (e) {
      fromNavBar = Get.arguments['fromNavBar'];
      isDriver = Get.arguments['isDriver'];
      fullName = Get.arguments['fullName'];
    }

    final RxBool isPlaying = true.obs;
    if (isPlaying.value) {
      confettiController.play();
    } else {
      confettiController.stop();
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}

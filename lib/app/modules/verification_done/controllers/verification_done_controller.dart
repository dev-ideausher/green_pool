import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';

class VerificationDoneController extends GetxController {
  bool fromNavBar = false;
  bool isDriver = false;
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
      } else {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
      }
    } catch (e) {
      isDriver = Get.arguments['isDriver'];
      fromNavBar = Get.arguments['fromNavBar'];
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

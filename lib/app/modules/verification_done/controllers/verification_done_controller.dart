import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

class VerificationDoneController extends GetxController {
  bool fromNavBar = false;
  bool isDriver = false;
  final confettiController = ConfettiController();

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments['isDriver'];
    fromNavBar = Get.arguments['fromNavBar'];
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

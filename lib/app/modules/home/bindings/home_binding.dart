import 'package:get/get.dart';

import '../../messages/controllers/messages_controller.dart';
import '../../my_rides_page/controllers/my_rides_page_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut<MessagesController>(() => MessagesController());
    Get.lazyPut<MyRidesPageController>(() => MyRidesPageController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

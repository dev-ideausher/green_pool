import 'package:get/get.dart';

import '../../../data/my_rides_model.dart';

class MyRidesDetailsController extends GetxController {
  // final Rx<MyRidesDetailsModel> myRideDetailsModel = MyRidesDetailsModel().obs;
  final Rx<MyRidesModelData> myRidesModelData = MyRidesModelData().obs;

  @override
  void onInit() {
    super.onInit();
    myRidesModelData.value = Get.arguments;
    // myRidesDetailsAPI();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // myRidesDetailsAPI() async {
  //   try {
  //     final response = await APIManager.getMyRidesDetails(rideId: myRidesModelData.value.Id ?? "");
  //     var data = jsonDecode(response.toString());
  //     myRideDetailsModel.value = MyRidesDetailsModel.fromJson(data);
  //     print(myRideDetailsModel.value);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_pool/app/data/my_rides_details_model.dart';

import '../../../services/dio/api_service.dart';

class MyRidesDetailsController extends GetxController {
  // var myRidesModel = Get.find<MyRidesController>().myRidesModel.value;
  var myRideDetailsModel = MyRidesDetailsModel().obs;
  String driverId = '';
  String origin = '';

  int index = 0;

  @override
  void onInit() {
    super.onInit();
    driverId = Get.arguments['driverId'];
    index = Get.arguments['index'];
    final origin = Get.arguments['origin'];
    final destination = Get.arguments['destination'];

    myRidesDetailsAPI(origin, destination);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // myRidesDetailsAPI(origin, destination) async {
  //   log("ride id that is coming from my_rides_one_time: $driverId");
  //   try {
  //     final response = await APIManager.getMyRidesDetails(rideId: driverId);
  //     var data = jsonDecode(response.toString());
  //     print(data.toString());
  //     myRideDetailsModel.value = MyRidesDetailsModel.fromJson(data);
  //     // myRideDetailsModel.value.data = MyRidesDetailsModelData(origin: );
  //     myRideDetailsModel.value.data?[0]?.destination?.name = destination;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  myRidesDetailsAPI(origin, destination) async {
    log("ride id that is coming from my_rides_one_time: $driverId");
    try {
      final response = await APIManager.getMyRidesDetails(rideId: driverId);
      var data = jsonDecode(response.toString());

      myRideDetailsModel.value = MyRidesDetailsModel.fromJson(data);
      List<MyRidesDetailsModelData> mList = [];
      mList.add(MyRidesDetailsModelData(
          origin: MyRidesDetailsModelDataOrigin(name: origin),
          destination: MyRidesDetailsModelDataDestination(name: destination)));
      myRideDetailsModel.value.data = mList;
    } catch (e) {
      throw Exception(e);
    }
  }
}

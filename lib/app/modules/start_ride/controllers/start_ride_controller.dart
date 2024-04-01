import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/data/my_rides_model.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';

import '../../home/controllers/home_controller.dart';

class StartRideController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  late GoogleMapController mapController;
  Set<Marker> markers = <Marker>{}.obs;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  final Rx<MyRidesModel> myRidesModel = MyRidesModel().obs;
  int index = 0;

  @override
  void onInit() {
    super.onInit();
    myRidesModel.value = Get.arguments['model'];
    index = Get.arguments['index'];
    getPolyPoints();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // mapController.setMapStyle(DespiiUtil.mapStyle);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Endpoints.googleApiKey,
        PointLatLng(
            myRidesModel.value.data?[index]?.origin?.coordinates?.last ?? //source
                19.0635747,
            myRidesModel.value.data?[index]?.origin?.coordinates?.first ?? 72.84047029999999),
        PointLatLng(
            myRidesModel.value.data?[index]?.destination?.coordinates?.last ?? //destination
                0.0,
            myRidesModel.value.data?[index]?.destination?.coordinates?.first ?? 0.0));
    if (result.points.isNotEmpty) {
      polylineCoordinates.assignAll(
        result.points.map((PointLatLng point) => LatLng(point.latitude, point.longitude)).toList(),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/data/driver_send_request_model.dart';
import 'package:green_pool/app/modules/map_driver_send_request/views/map_driver_send_bottomsheet.dart';

import '../../../services/dio/endpoints.dart';
import '../../../services/gp_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../my_rides_request/controllers/my_rides_request_controller.dart';
import '../views/rider_request_bottomsheet.dart';

class MapDriverSendRequestController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  var sendRequestModel = DriverSendRequestModel().obs;

  late GoogleMapController mapController;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  final Set<Marker> markers = <Marker>{}.obs;

  final RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          bearing: sendRequestModel.value.data?.first?.origin?.coordinates?.last ?? 0.0, target: LatLng(latitude, longitude), tilt: 30.0, zoom: 17.0),
    ));
    polylineCoordinates.refresh();
    createMarker();
  }

  drawPolyline(DriverSendRequestModelData element) async {
    try {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          Endpoints.googleApiKey,
          PointLatLng(element.origin?.coordinates?.last ?? 0.0, element.origin?.coordinates?.first ?? 0.0),
          PointLatLng(element.destination?.coordinates?.last ?? 0.0, element.destination?.coordinates?.first ?? 0.0),
          travelMode: TravelMode.driving);
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points.map((PointLatLng point) => LatLng(point.latitude, point.longitude)).toList());
        mapController.animateCamera(CameraUpdate.newLatLngBounds(GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
      }
    } catch (e) {
      debugPrint('Error in drawPolyline: $e');
    }
  }

  addMarkers(DriverSendRequestModelData element, LatLng riderLocation, imgurl) async {
    final bytes = await GpUtil.getMarkerIconFromUrl(imgurl);
    markers.add(Marker(
        markerId: MarkerId(riderLocation.toString()),
        position: riderLocation,
        onTap: () {
          Get.bottomSheet(RiderRequestBottomsheet(element: element), isScrollControlled: true);
        },
        // infoWindow: const InfoWindow(title: 'Rider', snippet: 'Rider'),
        icon: bytes));
  }

  void createMarker() {
    isLoading.value = true;
    markers.clear();
    sendRequestModel.value = Get.find<MyRidesRequestController>().sendRequestModel.value;
    markers.clear();
    sendRequestModel.value.data?.forEach((element) async {
      await addMarkers(
          element!, LatLng(element.origin?.coordinates?.last ?? 0.0, element?.origin?.coordinates?.first ?? 0.0), element?.riderDetails?[0]?.profilePic?.url);
      drawPolyline(element);
    });

    isLoading.value = false;
  }
}

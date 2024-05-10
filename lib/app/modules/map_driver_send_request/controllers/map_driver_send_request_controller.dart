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

class MapDriverSendRequestController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  var sendRequestModel = DriverSendRequestModel().obs;

  late GoogleMapController mapController;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  final Set<Marker> markers = <Marker>{}.obs;

  final RxDouble currentLat = 0.0.obs;
  final RxDouble currentLong = 0.0.obs;

  final RxDouble destinationLat = 0.0.obs;
  final RxDouble destinationLong = 0.0.obs;

  final RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 270.0,
        target: LatLng(latitude, longitude),
        tilt: 30.0,
        zoom: 17.0,
      ),
    ));
    polylineCoordinates.refresh();
    createMarker();
  }

  drawPolyline() async {
    try {
      markers.clear();
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
          Endpoints.googleApiKey,
          PointLatLng(latitude, longitude),
          PointLatLng(destinationLat.value, destinationLong.value),
          travelMode: TravelMode.driving);
      if (result.points.isNotEmpty) {
        polylineCoordinates.assignAll(result.points
            .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
            .toList());
        mapController.animateCamera(CameraUpdate.newLatLngBounds(
            GpUtil.boundsFromLatLngList(polylineCoordinates), 70));
      }
    } catch (e) {
      debugPrint('Error in drawPolyline: $e');
    }
  }

  addMarkers(LatLng riderLocation, imgurl) async {
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();
    markers.add(Marker(
      markerId: MarkerId(riderLocation.toString()),
      position: riderLocation, //position of marker
      onTap: () {
        Get.bottomSheet(const MapDriverSendBottomsheet());
      },
      infoWindow: const InfoWindow(
        title: 'Rider',
        snippet: 'Rider',
      ),
      icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
    ));
  }

  void createMarker() {
    isLoading.value = true;
    Get.find<MyRidesRequestController>()
        .sendRequestModel
        .value
        .data
        ?.forEach((element) async {
      await addMarkers(
          LatLng(element?.origin?.coordinates?.last ?? 0.0,
              element?.origin?.coordinates?.first ?? 0.0),
          element?.riderDetails?[0]?.profilePic?.url);
    });
    destinationLat.value =
        sendRequestModel.value.data?[0]?.destination?.coordinates?.last ?? 0.0;
    destinationLong.value =
        sendRequestModel.value.data?[0]?.destination?.coordinates?.first ?? 0.0;
    drawPolyline();
    isLoading.value = false;
  }
}

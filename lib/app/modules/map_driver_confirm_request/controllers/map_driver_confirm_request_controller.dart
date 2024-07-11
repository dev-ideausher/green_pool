import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/modules/map_driver_confirm_request/views/map_driver_confirm_bottomsheet.dart';
import 'package:green_pool/app/modules/my_rides_request/controllers/my_rides_request_controller.dart';

import '../../../data/driver_cofirm_request_model.dart';
import '../../../services/dio/endpoints.dart';
import '../../../services/gp_util.dart';
import '../../home/controllers/home_controller.dart';

class MapDriverConfirmRequestController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  var confirmRequestModel =
      Get.find<MyRidesRequestController>().confirmRequestModel;

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
        googleApiKey: Endpoints.googleApiKey,
        request: PolylineRequest(
            origin: PointLatLng(latitude, longitude),
            destination:
                PointLatLng(destinationLat.value, destinationLong.value),
            mode: TravelMode.driving),
      );
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

  addMarkers(
      DriverConfirmRequestModelData element, LatLng carLocation, imgurl) async {
    final bytes = await GpUtil.getMarkerIconFromUrl(imgurl);
    markers.add(Marker(
      markerId: MarkerId(carLocation.toString()),
      position: carLocation,
      //position of marker
      onTap: () {
        Get.bottomSheet(MapDriverConfirmBottomsheet(element: element));
      },
      infoWindow: const InfoWindow(
        title: 'Rider',
        snippet: '',
      ),
      icon: bytes, //Icon for Marker
    ));
  }

  void createMarker() {
    isLoading.value = true;
    confirmRequestModel.value.data?.forEach((element) async {
      await addMarkers(
          element!,
          LatLng(element?.rideDetails?.first?.origin?.coordinates?.last ?? 0.0,
              element?.rideDetails?.first?.origin?.coordinates?.first ?? 0.0),
          element?.rideDetails?.first?.riderDetails?[0]?.profilePic?.url);
    });
    destinationLat.value = confirmRequestModel
            .value.data?[0]?.rideDetails?[0]?.destination?.coordinates?.last ??
        0.0;
    destinationLong.value = confirmRequestModel
            .value.data?[0]?.rideDetails?[0]?.destination?.coordinates?.first ??
        0.0;
    drawPolyline();
    isLoading.value = false;
  }
}

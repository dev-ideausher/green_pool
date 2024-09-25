import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/rider_confirm_request_model.dart';
import '../../../services/dio/endpoints.dart';
import '../../../services/gp_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../rider_my_ride_request/controllers/rider_my_ride_request_controller.dart';
import '../views/map_rider_confirm_bottomsheet.dart';

class MapRiderConfirmRequestController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  var riderConfirmRequestModel = RiderConfirmRequestModel().obs;

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
              mode: TravelMode.driving));
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

  addMarkers(RiderConfirmRequestModelData element, LatLng driverLocation,
      imgurl) async {
    final bytes = await GpUtil.getMarkerIconFromUrl(imgurl);
    markers.add(Marker(
        markerId: MarkerId(driverLocation.toString()),
        position: driverLocation,
        onTap: () {
          Get.bottomSheet(MapRiderConfirmBottomsheet(element: element),
              isScrollControlled: true);
        },
        // infoWindow: const InfoWindow(title: 'Rider', snippet: 'Rider'),
        icon: bytes));
  }

  void createMarker() {
    isLoading.value = true;
    riderConfirmRequestModel.value =
        Get.find<RiderMyRideRequestController>().riderConfirmRequestModel.value;
    riderConfirmRequestModel.value.data?.forEach((element) async {
      await addMarkers(
          element!,
          LatLng(element?.driverRideDetails?.origin?.coordinates?.last ?? 0.0,
              element?.driverRideDetails?.origin?.coordinates?.first ?? 0.0),
          element?.driverRideDetails?.driverDetails?[0]?.profilePic?.url);
    });
    destinationLat.value = riderConfirmRequestModel.value.data?[0]
            ?.driverRideDetails?.destination?.coordinates?.last ??
        0.0;
    destinationLong.value = riderConfirmRequestModel.value.data?[0]
            ?.driverRideDetails?.destination?.coordinates?.first ??
        0.0;
    drawPolyline();
    isLoading.value = false;
  }

  @override
  void onClose() {
    mapController.dispose();
    markers.clear();
    polylineCoordinates.clear();
    super.onClose();
  }
}

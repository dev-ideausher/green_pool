import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../home/controllers/home_controller.dart';

class RiderStartRideMapController extends GetxController {
  double latitude = Get.find<HomeController>().latitude.value;
  double longitude = Get.find<HomeController>().longitude.value;
  late GoogleMapController mapController;
  final Set<Marker> markers = <Marker>{}.obs;
  final RxList<LatLng> polylineCoordinates = <LatLng>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 270.0,
        target: LatLng(latitude, longitude),
        // LatLng(
        //     myRidesModel.value.origin?.coordinates?.last ?? //source
        //         0.0,
        //     myRidesModel.value.origin?.coordinates?.first ?? 0.0),
        tilt: 30.0,
        zoom: 17.0,
      ),
    ));
    mapController.animateCamera(CameraUpdate.newLatLngBounds(
        boundsFromLatLngList(polylineCoordinates), 60));

    polylineCoordinates.refresh();
    liveUpdateLocation();
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double minLat = list.first.latitude;
    double maxLat = list.first.latitude;
    double minLng = list.first.longitude;
    double maxLng = list.first.longitude;
    for (LatLng point in list) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }
    return LatLngBounds(
        southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng));
  }

  StreamSubscription<Position>? driversPositionStream;

  void liveUpdateLocation() async {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    try {
      driversPositionStream =
          await Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position? position) async {
        if (position != null) {
          final currentLat = position.latitude;
          final currentLong = position.longitude;
          // myRidesModel.value.origin?.coordinates = [currentLong, currentLat];
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 13.5,
                target: LatLng(currentLat, currentLong),
              ),
            ),
          );
          // await getPolyPoints();
          polylineCoordinates.refresh();
        }
      });
      // Timer.periodic(const Duration(minutes: 1), (Timer t) {
      //   if (Get.find<GetStorageService>().isRider &&
      //       Get.find<GetStorageService>().jwToken.isNotEmpty) {
      //     sendLocationToServer(currentPosition);
      //   } else {
      //     t.cancel();
      //   }
      // });
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }
}

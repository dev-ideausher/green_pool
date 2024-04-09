import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/colors.dart';
import '../controllers/rider_start_ride_map_controller.dart';

class RiderStartRideMapView extends GetView<RiderStartRideMapController> {
  const RiderStartRideMapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 0.0),
          zoom: 14,
        ),
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: controller.onMapCreated,
        mapType: MapType.terrain,
        markers: Set<Marker>.of(controller.markers),
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            visible: true,
            width: 4,
            color: ColorUtil.kSecondary01,
            points: controller.polylineCoordinates,
          ),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/colors.dart';
import '../controllers/start_ride_controller.dart';

class StartRideView extends GetView<StartRideController> {
  const StartRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StartRideView'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.myRidesModel.value.origin?.coordinates?.last ?? 0.0, controller.myRidesModel.value.origin?.coordinates?.first ?? 0.0),
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
      ),
    );
  }
}

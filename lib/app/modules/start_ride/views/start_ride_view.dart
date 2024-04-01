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
      body: Center(
          child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              controller.myRidesModel.value.data?[controller.index]?.origin
                      ?.coordinates?.last ??
                  0.0,
              controller.myRidesModel.value.data?[controller.index]?.origin
                      ?.coordinates?.first ??
                  0.0),
          zoom: 14,
        ),
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: controller.onMapCreated,
        mapType: MapType.terrain,
        markers: {
          Marker(
            markerId: const MarkerId("source"),
            icon: controller.sourceIcon,
            position: LatLng(
                controller.myRidesModel.value.data?[controller.index]?.origin
                        ?.coordinates?.last ??
                    19.0635747,
                controller.myRidesModel.value.data?[controller.index]?.origin
                        ?.coordinates?.first ??
                    72.84047029999999),
          ),
          Marker(
            markerId: const MarkerId("destination"),
            icon: controller.destinationIcon,
            position: LatLng(
                controller.myRidesModel.value.data?[controller.index]
                        ?.destination?.coordinates?.last ??
                    19.0635747,
                controller.myRidesModel.value.data?[controller.index]
                        ?.destination?.coordinates?.first ??
                    72.84047029999999),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            visible: true,
            width: 4,
            color: ColorUtil.kSecondary01,
            points: controller.polylineCoordinates,
          ),
        },
      )),
    );
  }
}

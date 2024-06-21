import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/rider_start_ride_map_controller.dart';
import 'arriving_bottom_sheet.dart';

class RiderStartRideMapView extends GetView<RiderStartRideMapController> {
  const RiderStartRideMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: LatLng(controller.currentLat.value,
                        controller.currentLong.value),
                    zoom: 14),
                mapType: MapType.terrain,
                myLocationEnabled: true,
                markers: Set<Marker>.of(controller.markers),
                zoomGesturesEnabled: true,
                polylines: {
                  Polyline(
                      polylineId: const PolylineId('polyline'),
                      points: controller.polylineCoordinates,
                      width: 4,
                      color: ColorUtil.kSecondary01),
                },
              ).paddingOnly(bottom: 210.kh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorUtil.kError4,
        onPressed: () => controller.sos(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.notifications_active_outlined,
                color: ColorUtil.kWhiteColor),
            Text(Strings.sos,
                style: TextStyleUtil.k14Regular(
                    color: ColorUtil.kWhiteColor, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      bottomSheet: const ArrivingBottomSheet(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/generated/assets.dart';

import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/origin_to_destination.dart';
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
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: LatLng(0.0, 0.0), zoom: 14),
                mapType: MapType.normal,
                markers: Set<Marker>.of(controller.markers),
                polylines: {
                  Polyline(
                    visible: true,
                    width: 4,
                    polylineId: const PolylineId('polyline'),
                    points: controller.polylineCoordinates,
                    patterns: [PatternItem.dash(10), PatternItem.gap(10)],
                  ),
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorUtil.kError4,
        onPressed: () {},
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

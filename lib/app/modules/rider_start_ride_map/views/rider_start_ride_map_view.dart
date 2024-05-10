import 'dart:async';

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
import '../../../services/custom_button.dart';
import '../../../services/gp_util.dart';
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
                initialCameraPosition: CameraPosition(
                    target: LatLng(controller.latitude, controller.longitude),
                    zoom: 14),
                mapType: MapType.terrain,
                markers: Set<Marker>.of(controller.markers),
                // onCameraMove: (position) {
                //   GpUtil.moveCamera(controller.mapController, position.target);
                // },
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
        onPressed: () {
          Get.dialog(
            useSafeArea: true,
            Center(
              child: Container(
                padding: EdgeInsets.all(16.kh),
                height: 50.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: ColorUtil.kWhiteColor,
                  borderRadius: BorderRadius.circular(8.kh),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sending SOS',
                      style: TextStyleUtil.k24Heading700(),
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(vertical: 4.kh),
                    SizedBox(),
                    Text(
                      'Share message and location with emergency contacts',
                      style: TextStyleUtil.k14Regular(
                        color: ColorUtil.kBlack04,
                      ),
                      textAlign: TextAlign.center,
                    ).paddingOnly(bottom: 40.kh),
                    GreenPoolButton(
                      onPressed: () {},
                      height: 40.kh,
                      width: 60.w,
                      label: 'Cancel',
                      fontSize: 14.kh,
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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

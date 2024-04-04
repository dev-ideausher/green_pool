import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../controllers/start_ride_controller.dart';

class StartRideView extends GetView<StartRideController> {
  const StartRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 230.kh,
        padding: EdgeInsets.symmetric(horizontal: 16.kw),
        decoration: const BoxDecoration(color: ColorUtil.kWhiteColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Carpool Companions'),
                SizedBox(
                  height: 24.kh,
                  width: 28.w,
                  child: ListView.builder(
                    itemCount: 4,
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index1) {
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(12.kh),
                            child: Image.asset(
                              ImageConstant.pngEmptyPassenger,
                            ),
                          ),
                        ),
                      ).paddingOnly(right: 4.kw);
                    },
                  ),
                ),
              ],
            ),
            const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 16.kh),
            OriginToDestination(
                origin: "${controller.myRidesModel.value.origin?.name}",
                destination:
                    "${controller.myRidesModel.value.destination?.name}"),
            GreenPoolButton(
              onPressed: () {},
              label: "Start Ride",
            ).paddingSymmetric(vertical: 16.kh),
          ],
        ).paddingOnly(top: 24.kh),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          controller.myRidesModel.value.origin?.coordinates
                                  ?.last ??
                              0.0,
                          controller.myRidesModel.value.origin?.coordinates
                                  ?.first ??
                              0.0),
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
                ],
              ).paddingOnly(bottom: 230.kh),
      ),
    );
  }
}

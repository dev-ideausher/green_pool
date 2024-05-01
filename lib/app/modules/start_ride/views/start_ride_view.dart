import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../constants/image_constant.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/start_ride_controller.dart';

class StartRideView extends GetView<StartRideController> {
  const StartRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      controller.myRidesModel.value.riderBookingDetails?.origin
                              ?.coordinates?.last ??
                          0.0,
                      controller.myRidesModel.value.riderBookingDetails?.origin
                              ?.coordinates?.first ??
                          0.0),
                  zoom: 14,
                ),
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: controller.onMapCreated,
                onCameraMove: (position) {
                  GpUtil.moveCamera(controller.mapController, position.target);
                },
                mapType: MapType.terrain,
                markers: Set<Marker>.of(controller.markers),
                polylines: {
                  Polyline(
                      polylineId: const PolylineId('route'),
                      visible: true,
                      width: 4,
                      color: ColorUtil.kSecondary01,
                      points: controller.polylineCoordinates)
                },
              ),
      ),
      bottomSheet: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.kh),
                              topRight: Radius.circular(8.kh))),
                      margin: EdgeInsets.zero,
                      color: ColorUtil.kSecondary01,
                      child: ListTile(
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          leading: const Icon(Icons.email_outlined,
                              color: ColorUtil.kWhiteColor),
                          title: Text(Strings.riderNotified,
                              style: TextStyleUtil.k14Regular(
                                  color: ColorUtil.kWhiteColor)))),
                  8.kheightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Strings.currentRiders),
                      SizedBox(
                        height: 24.kh,
                        width: 28.w,
                        child: ListView.builder(
                          itemCount: controller.myRidesModel.value
                              .driverBookingDetails?.riders?.length,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            final rider = controller.myRidesModel.value
                                .driverBookingDetails!.riders![index1];
                            return Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(12.kh),
                                  child: controller.myRidesModel.value
                                          .driverBookingDetails!.riders!.isEmpty
                                      ? Image.asset(
                                          ImageConstant.pngEmptyPassenger,
                                        )
                                      : Image(
                                          image: NetworkImage(
                                              "${rider?.profilePic?.url}"),
                                        ),
                                ),
                              ),
                            ).paddingOnly(right: 4.kw);
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 12.kw),
                  8.kheightBox,
                  ListTile(
                    leading: SizedBox(
                        height: 50.kh,
                        width: 50.kh,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CommonImageView(
                                url: controller
                                    .myRidesModel
                                    .value
                                    .riderBookingDetails
                                    ?.riderDetails
                                    ?.profilePic
                                    ?.url,
                                height: 40,
                                width: 40))),
                    title: Text(
                        controller.myRidesModel.value.riderBookingDetails
                                ?.riderDetails?.fullName ??
                            "",
                        style: TextStyleUtil.k16Medium()),
                    /* subtitle: Text(
                    "${controller.myRidesModel.value.confirmDriverDetails?.first?.driverPostsDetails?.first?.driverDetails?.first?.vehicleDetails?.first?.color ?? ""} ${controller.myRidesModel.value.confirmDriverDetails?.first?.driverPostsDetails?.first?.driverDetails?.first?.vehicleDetails?.first?.model ?? ""}",
                    style: TextStyleUtil.k16Medium()),*/
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(
                                "tel:${controller.myRidesModel.value.riderBookingDetails?.riderDetails?.phone}"));
                          },
                          child: CommonImageView(
                            svgPath: Assets.iconsCall,
                          ),
                        ),
                        12.kwidthBox,
                        InkWell(
                          onTap: () => controller.showChatBottomSheet(),
                          child: CommonImageView(
                            svgPath: Assets.iconsChat,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const GreenPoolDivider()
                      .paddingOnly(top: 8.kh, bottom: 16.kh),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.kw),
                    child: OriginToDestination(
                        needPickupText: true,
                        origin:
                            "${controller.myRidesModel.value.riderBookingDetails?.origin?.name}",
                        destination:
                            "${controller.myRidesModel.value.riderBookingDetails?.destination?.name}"),
                  ),
                  Obx(
                    () => GreenPoolButton(
                      onPressed: controller.isRideStarted.value
                          ? () async {
                              //end ride and go to rating page
                              await controller.endRideAPI();
                              //in between rider picked up and dropped
                            }
                          : () async {
                              await controller.startRideAPI();
                            },
                      label: controller.isRideStarted.value
                          ? controller.myRidesModel.value.driverBookingDetails!
                                  .isStarted!
                              ? Strings.riderPickedUpSuccessfully
                              : Strings.endRide
                          : Strings.startRide,
                    ).paddingSymmetric(vertical: 16.kh),
                  ),
                ],
              ).paddingOnly(top: 24.kh),
      ),
    );
  }
}

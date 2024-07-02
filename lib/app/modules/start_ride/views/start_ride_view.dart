import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/custom_button.dart';
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
      // appBar: const GreenPoolAppBar(),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.getLat(), controller.getLong()),
                  zoom: 14,
                ),
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: controller.onMapCreated,
                // onCameraMove: (position) {
                //   GpUtil.moveCamera(controller.mapController, position.target);
                // },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Get.find<HomeController>().isPinkModeOn.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kSecondary01,
                onPressed: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: ColorUtil.kWhiteColor,
                  size: 24.kh,
                ),
              ).paddingOnly(bottom: 4.kh, left: 24.kw),
              FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kSecondaryPinkMode
                      : ColorUtil.kPrimary05,
                  tooltip: Strings.openGoogleMaps,
                  onPressed: () {
                    controller.openGoogleMaps();
                  },
                  child: CommonImageView(
                    svgPath: ImageConstant.svgGooleMaps,
                  )).paddingOnly(bottom: 4.kh),
            ],
          ),
          Text(Strings.openGoogleMaps,
              style: TextStyleUtil.k12Bold(
                  color: ColorUtil.kBlueColor, fontWeight: FontWeight.w700)),
        ],
      ).paddingOnly(top: 8.kh),
      bottomSheet: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Container(
                color: ColorUtil.kWhiteColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (controller.myRidesModel.value.driverBookingDetails
                                ?.isStarted ??
                            false)
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.kh),
                                    topRight: Radius.circular(8.kh))),
                            margin: EdgeInsets.zero,
                            color: ColorUtil.kSecondary01,
                            child: ListTile(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                leading: const Icon(Icons.email_outlined,
                                    color: ColorUtil.kWhiteColor),
                                title: Text(Strings.riderNotified,
                                    style: TextStyleUtil.k14Regular(
                                        color: ColorUtil.kWhiteColor))))
                        : const SizedBox(),
                    8.kheightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Strings.currentRiders),
                        SizedBox(
                          height: 30.kh,
                          width: 28.w,
                          child: ListView.builder(
                            itemCount: controller
                                .myRidesModel
                                .value
                                .driverBookingDetails
                                ?.riderBookingDetails
                                ?.length,
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index1) {
                              final rider = controller
                                  .myRidesModel
                                  .value
                                  .driverBookingDetails!
                                  .riderBookingDetails![index1];
                              return InkWell(
                                onTap: () => controller.updateIndex(index1),
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: controller.selectedRider.value ==
                                                index1
                                            ? ColorUtil.kPrimary3PinkMode
                                            : Colors.transparent,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(16.kh),
                                  ),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(12.kh),
                                      child: controller
                                              .myRidesModel
                                              .value
                                              .driverBookingDetails!
                                              .riders!
                                              .isEmpty
                                          ? Image.asset(
                                              ImageConstant.pngEmptyPassenger,
                                            )
                                          : CommonImageView(
                                              url:
                                                  "${rider?.riderDetails?.profilePic?.url}"),
                                    ),
                                  ),
                                ).paddingOnly(right: 4.kw),
                              );
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
                                  url: controller.getImage(),
                                  height: 40,
                                  width: 40))),
                      title: Text(controller.getName(),
                          style: TextStyleUtil.k16Medium()),
                      /* subtitle: Text(
                      "${controller.myRidesModel.value.confirmDriverDetails?.first?.driverPostsDetails?.first?.driverDetails?.first?.vehicleDetails?.first?.color ?? ""} ${controller.myRidesModel.value.confirmDriverDetails?.first?.driverPostsDetails?.first?.driverDetails?.first?.vehicleDetails?.first?.model ?? ""}",
                      style: TextStyleUtil.k16Medium()),*/
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () async {
                              await launchUrl(
                                  Uri.parse("tel:${controller.getPhone()}"));
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
                        origin: controller.getOrigin(),
                        destination: controller.getDestination(),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: !(controller
                                .myRidesModel
                                .value
                                .driverBookingDetails
                                ?.riderBookingDetails?[
                                    controller.selectedRider.value]
                                .isCompleted ??
                            false),
                        child: GreenPoolButton(
                          onPressed: () => controller.actionTap(),
                          label: controller.btnText.value,
                        ).paddingSymmetric(vertical: 16.kh),
                      ),
                    ),
                    Visibility(
                      visible: controller.isEndRide.value,
                      child: GreenPoolButton(
                        onPressed: () => controller.actionTap(),
                        label: controller.btnText.value,
                      ).paddingSymmetric(vertical: 16.kh),
                    ),
                  ],
                ).paddingOnly(bottom: 34.kh),
              ),
      ),
    );
  }
}

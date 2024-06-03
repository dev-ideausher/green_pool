import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/assets.dart';
import '../../../components/common_image_view.dart';
import '../../../components/origin_to_destination.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/rider_start_ride_map_controller.dart';

class ArrivingBottomSheet extends StatelessWidget {
  const ArrivingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiderStartRideMapController>(builder: (controller) {
      return Obx(
        () =>controller.isLoad.value?GpProgress(): Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8.kh), topRight: Radius.circular(8.kh))),
                margin: EdgeInsets.zero,
                color: ColorUtil.kSecondary01,
                child: ListTile(
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  leading: const Icon(Icons.access_time_rounded, color: ColorUtil.kWhiteColor),
                  title: Text(controller.getMsg(), style: TextStyleUtil.k14Regular(color: ColorUtil.kWhiteColor)),
                )),
            12.kheightBox,
            ListTile(
              leading: SizedBox(
                  height: 50.kh,
                  width: 50.kh,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CommonImageView(url: controller.bookingDetail.value.driverDetails?.vehicleDetails?.vehiclePic?.url, height: 30, width: 30),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CommonImageView(url: controller.bookingDetail.value.driverDetails?.profilePic?.url, height: 40, width: 40),
                        ),
                      ),
                    ],
                  )),
              title: Text(controller.bookingDetail.value.driverDetails?.fullName ?? "", style: TextStyleUtil.k16Medium()),
              subtitle: Text(
                  "${controller.bookingDetail.value.driverDetails?.vehicleDetails?.color ?? ""} ${controller.bookingDetail.value.driverDetails?.vehicleDetails?.model ?? ""}",
                  style: TextStyleUtil.k16Medium()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => controller.callToDriver(),
                    child: CommonImageView(
                      svgPath: Assets.iconsCall,
                    ),
                  ),
                  12.kwidthBox,
                  InkWell(
                    onTap: () => controller.chatWithDriver(),
                    child: CommonImageView(
                      svgPath: Assets.iconsChat,
                    ),
                  ),
                ],
              ),
            ),
            12.kheightBox,
            OriginToDestination(
                    needPickupText: true,
                    origin: "${controller.bookingDetail.value.driverBookingDetails?.origin?.name}",
                    destination: "${controller.bookingDetail.value.driverBookingDetails?.destination?.name}")
                .paddingSymmetric(horizontal: 12.kw),
            24.kheightBox,
          ],
        ),
      );
    });
  }
}

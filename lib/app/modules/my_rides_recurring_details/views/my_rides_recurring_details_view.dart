import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/gp_progress.dart';
import '../../../components/green_pool_divider.dart';
import '../../../components/route_widget.dart';
import '../../../data/ride_detail_id.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../post_ride_step_one/views/amenities.dart';
import '../controllers/my_rides_recurring_details_controller.dart';

class MyRidesRecurringDetailsView
    extends GetView<MyRidesRecurringDetailsController> {
  const MyRidesRecurringDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_rideDetails.tr),
      ),
      body: Obx(() {
        final driverDetails =
            controller.recurringModel.value.data?.driverRideDetails?[0];
        final otherPrefs = driverDetails?.preferences?.other;
        return controller.isLoading.value
            ? const GpProgress()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //details with pick up and drop off
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.app_pickupToDrop.tr,
                          style: TextStyleUtil.k16Bold(),
                        ),
                        RouteWidget(
                          needPickUp: true,
                          stop1: "",
                          stop2: "",
                          origin: "${driverDetails?.origin?.name}",
                          destination: "${driverDetails?.destination?.name}",
                        ),
                        const GreenPoolDivider(),
                      ],
                    ).paddingOnly(bottom: 16.kh),

                    //Vehicle details
                    Text(
                      LocaleKeys.app_vehicleDetails.tr,
                      style: TextStyleUtil.k14Bold(),
                    ).paddingOnly(bottom: 16.kh),
                    Row(
                      children: [
                        ClipRRect(
                                borderRadius: BorderRadius.circular(8.kh),
                                child: SizedBox(
                                    height: 64.kh,
                                    width: 64.kw,
                                    child: CommonImageView(
                                        url:
                                            "${driverDetails?.driverVehiclesDetails?[0]?.vehiclePic?.url}")))
                            .paddingOnly(right: 8.kw),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${driverDetails?.driverVehiclesDetails?[0]?.model}',
                              style: TextStyleUtil.k16Bold(
                                  color: ColorUtil.kBlack02),
                            ).paddingOnly(bottom: 4.kh),
                            Row(
                              children: [
                                Text(
                                  '${driverDetails?.driverVehiclesDetails?[0]?.type}',
                                  style: TextStyleUtil.k14Semibold(
                                      color: ColorUtil.kBlack03),
                                ),
                                Container(
                                  width: 1.kw,
                                  height: 16.kh,
                                  color: ColorUtil.kBlack03,
                                ).paddingSymmetric(
                                    vertical: 2.5.kh, horizontal: 8.kw),
                                Text(
                                  '${driverDetails?.driverVehiclesDetails?[0]?.licencePlate}',
                                  style: TextStyleUtil.k14Semibold(
                                      color: ColorUtil.kBlack03),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),

                    //Features available
                    Text(
                      LocaleKeys.app_featuresAvailable.tr,
                      style: TextStyleUtil.k14Bold(),
                    ).paddingOnly(bottom: 16.kh),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 24.kw,
                        runSpacing: 12.kh,
                        children: [
                          if (otherPrefs?.AppreciatesConversation == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_appreciatesConversation.tr,
                              image: ImageConstant.svgAmenities1,
                            ),
                          if (otherPrefs?.EnjoysMusic == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_enjoysMusic.tr,
                              image: ImageConstant.svgAmenities2,
                            ),
                          if (otherPrefs?.SmokeFree == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_smokeFree.tr,
                              image: ImageConstant.svgAmenities3,
                            ),
                          if (otherPrefs?.PetFriendly == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_petFriendly.tr,
                              image: ImageConstant.svgAmenities4,
                            ),
                          if (otherPrefs?.WinterTires == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_winterTires.tr,
                              image: ImageConstant.svgAmenities5,
                            ),
                          if (otherPrefs?.CoolingOrHeating == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_coolingOrHeating.tr,
                              image: ImageConstant.svgAmenities6,
                            ),
                          if (otherPrefs?.BabySeat == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_babySeat.tr,
                              image: ImageConstant.svgAmenities7,
                            ),
                          if (otherPrefs?.HeatedSeats == true)
                            Amenities(
                              toggleSwitch: false,
                              text: LocaleKeys.app_heatedSeats.tr,
                              image: ImageConstant.svgAmenities8,
                            ),
                        ],
                      ),
                    ),

                    /*const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
                    Text(
                      LocaleKeys.app_description.tr,
                      style: TextStyleUtil.k14Bold(),
                    ).paddingOnly(bottom: 8.kh),
                    Wrap(
                      children: [
                        Text(
                          controller.recurringModel.value.data
                                  ?.driverRideDetails?[0]?.description ??
                              "NA",
                          style: TextStyleUtil.k14Semibold(),
                        )
                      ],
                    ),*/
                    const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
                    SizedBox(
                      height: controller.recurringModel.value.data!
                              .recurringRides!.length *
                          116.kh,
                      child: ListView.builder(
                          itemCount: controller.recurringModel.value.data
                              ?.recurringRides?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final recurringRides = controller.recurringModel
                                .value.data?.recurringRides?[index];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${controller.getDateFormat(recurringRides?.date ?? "")}",
                                          style: TextStyleUtil.k14Semibold(
                                              color: ColorUtil.kBlack02),
                                        ),
                                        2.kwidthBox,
                                        Visibility(
                                          visible:
                                              (recurringRides?.totalRequests ??
                                                      0) >
                                                  0,
                                          child: _requestCount(
                                              Get.find<HomeController>()
                                                  .isPinkModeOn
                                                  .value,
                                              recurringRides?.totalRequests
                                                      ?.toString() ??
                                                  ""),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.kh,
                                      child: ListView.builder(
                                        itemCount: ((recurringRides
                                                    ?.seatAvailable ??
                                                0) +
                                            (recurringRides?.riders!.length ??
                                                0)),
                                        reverse: true,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index1) {
                                          bool isSeatAvailable = index1 <
                                              (recurringRides?.seatAvailable ??
                                                  0);
                                          return Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: Size.fromRadius(12.kh),
                                                  child: isSeatAvailable
                                                      ? CommonImageView(
                                                          imagePath: ImageConstant
                                                              .pngEmptyPassenger,
                                                        )
                                                      : CommonImageView(
                                                          url:
                                                              "${recurringRides?.riders?[index1 - (recurringRides.seatAvailable ?? 0)]?.profilePic?.url}",
                                                        )),
                                            ),
                                          ).paddingOnly(right: 4.kw);
                                        },
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(bottom: 24.kh),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GreenPoolButton(
                                      label:
                                          LocaleKeys.app_viewMatchingRiders.tr,
                                      height: 40.kh,
                                      width: 192.kw,
                                      fontSize: 14.kh,
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        Get.toNamed(Routes.MY_RIDES_REQUEST,
                                            arguments: RideDetailId(
                                                driverRidId:
                                                    recurringRides?.Id ?? "",
                                                riderRidId: ""));
                                      }),
                                )
                              ],
                            ).paddingOnly(bottom: 24.kh);
                          }),
                    ),
                    24.kheightBox,
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              );
      }),
    );
  }

  Container _requestCount(bool isPinkModeOn, String pendingReq) {
    return Container(
      padding: EdgeInsets.all(6.kh),
      decoration: BoxDecoration(
        color:
            isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kPrimary01,
        shape: BoxShape.circle,
      ),
      child: Text(
        pendingReq,
        style: TextStyleUtil.k12Regular(),
      ),
    );
  }
}

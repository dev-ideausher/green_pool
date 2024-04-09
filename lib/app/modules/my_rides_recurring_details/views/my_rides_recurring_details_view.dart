import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/my_rides_recurring_details_controller.dart';

class MyRidesRecurringDetailsView
    extends GetView<MyRidesRecurringDetailsController> {
  const MyRidesRecurringDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Ride Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //details with pick up and drop off
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Origin to Destination",
                  style: TextStyleUtil.k16Bold(),
                ).paddingOnly(bottom: 16.kh),
                const OriginToDestination(
                  origin: "Origin",
                  destination: "Destination",
                ).paddingOnly(bottom: 8.kh),
                //bottom line
                const GreenPoolDivider(),
              ],
            ).paddingOnly(bottom: 16.kh),

            const GreenPoolDivider().paddingOnly(bottom: 16.kh),

            //Vehicle details
            Text(
              'Vehicle Details',
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.kh),
                  child: SizedBox(
                      height: 64.kh,
                      width: 64.kw,
                      child: Image.asset(ImageConstant.pngEmptyPassenger)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Model',
                      style: TextStyleUtil.k16Bold(color: ColorUtil.kBlack02),
                    ).paddingOnly(bottom: 4.kh),
                    Row(
                      children: [
                        Text(
                          'Type',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack03),
                        ),
                        Container(
                          width: 1.kw,
                          height: 16.kh,
                          color: ColorUtil.kBlack03,
                        ).paddingSymmetric(vertical: 2.5.kh, horizontal: 8.kw),
                        Text(
                          'License plate',
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
              'Features available',
              style: TextStyleUtil.k14Bold(),
            ).paddingOnly(bottom: 16.kh),

            // controller.myRidesModelData.value.preferences?.other
            //             ?.AppreciatesConversation ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Appreciates Conversation",
            //             image: ImageConstant.svgAmenities1)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.EnjoysMusic ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Enjoys Music",
            //             image: ImageConstant.svgAmenities2)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.SmokeFree ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Some-Free",
            //             image: ImageConstant.svgAmenities3)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.PetFriendly ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Pet-friendly",
            //             image: ImageConstant.svgAmenities4)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.WinterTires ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Winter Tires",
            //             image: ImageConstant.svgAmenities5)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.CoolingOrHeating ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Cooling or Heating",
            //             image: ImageConstant.svgAmenities6)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.BabySeat ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Baby Seats",
            //             image: ImageConstant.svgAmenities7)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),
            // controller.myRidesModelData.value.preferences?.other
            //             ?.HeatedSeats ==
            //         true
            //     ? Amenities(
            //             toggleSwitch: false,
            //             text: "Heated Seats",
            //             image: ImageConstant.svgAmenities8)
            //         .paddingOnly(bottom: 8.kh)
            //     : const SizedBox(),

            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            Text(
              "Description",
              style: TextStyleUtil.k14Semibold(),
            ),
            // Wrap(
            //   children: [
            //     Text("${controller.myRidesModelData.value.description}")
            //   ],
            // ),
            const GreenPoolDivider().paddingSymmetric(vertical: 16.kh),
            SizedBox(
              height: controller.numberOfDays * 112.kh,
              child: ListView.builder(
                  itemCount: controller.numberOfDays,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Monday 4th March",
                              style: TextStyleUtil.k14Semibold(
                                  color: ColorUtil.kBlack02),
                            ),
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
                        ).paddingOnly(bottom: 24.kh),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GreenPoolButton(
                              label: "View Matching Riders",
                              height: 40.kh,
                              width: 192.kw,
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                // Get.toNamed(Routes.MY_RIDES_REQUEST,
                                //     arguments: controller.myRidesModelData.value.Id);
                              }),
                        )
                      ],
                    ).paddingOnly(bottom: 24.kh);
                  }),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

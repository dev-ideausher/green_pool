//! contains recurring ride view in my rides
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/my_rides_recurring_controller.dart';

class MyRidesRecurringView extends GetView<MyRidesRecurringController> {
  const MyRidesRecurringView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyRidesRecurringController());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.MY_RIDES_RECURRING_DETAILS);
                    },
                    child: GestureDetector(
                      //! for testing
                      onTap: () {
                        // Get.toNamed(Routes.RIDER_START_RIDE_MAP);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.kh),
                        decoration: BoxDecoration(
                            color: ColorUtil.kWhiteColor,
                            borderRadius: BorderRadius.circular(8.kh)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO: toggle switch
                                Text(
                                  '10:30',
                                  style: TextStyleUtil.k16Semibold(
                                      fontSize: 16.kh),
                                ),
                                Obx(
                                  () => Transform.scale(
                                    scale: 0.8.kh,
                                    child: Switch(
                                      value: controller.isScheduled.value,
                                      onChanged: (value) {
                                        controller.isScheduled.value = value;
                                      },
                                      inactiveThumbColor: ColorUtil.kNeutral1,
                                      inactiveTrackColor:
                                          Get.find<ProfileController>()
                                                  .isSwitched
                                                  .value
                                              ? ColorUtil.kSecondaryPinkMode
                                              : ColorUtil.kPrimary05,
                                      activeTrackColor:
                                          Get.find<ProfileController>()
                                                  .isSwitched
                                                  .value
                                              ? ColorUtil.kPrimary3PinkMode
                                              : ColorUtil.kSecondary01,
                                      trackOutlineWidth:
                                          const MaterialStatePropertyAll(0),
                                      thumbColor:
                                          const MaterialStatePropertyAll(
                                              ColorUtil.kWhiteColor),
                                      trackOutlineColor:
                                          const MaterialStatePropertyAll(
                                              ColorUtil.kNeutral1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const GreenPoolDivider()
                                .paddingOnly(top: 8.kh, bottom: 16.kh),
                            const OriginToDestination(
                                    origin: '1100 McIntosh St, Regina',
                                    destination: '681 Chrislea Rd, Woodbridge')
                                .paddingOnly(bottom: 8.kh),
                            const GreenPoolDivider()
                                .paddingOnly(top: 8.kh, bottom: 16.kh),
                            Text(
                              "Rider Details",
                              style: TextStyleUtil.k14Bold(),
                            ).paddingOnly(bottom: 16.kh),
                            SizedBox(
                              height: controller.itemCount * 36.kh,
                              child: ListView.builder(
                                  itemCount: controller.itemCount,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                    size:
                                                        Size.fromRadius(12.kh),
                                                    child: Image.asset(
                                                      ImageConstant
                                                          .pngEmptyPassenger,
                                                    ),
                                                  ),
                                                ),
                                              ).paddingOnly(right: 4.kw);
                                            },
                                          ),
                                        ),
                                      ],
                                    ).paddingOnly(bottom: 12.kh);
                                  }),
                            )
                          ],
                        ),
                      ).paddingOnly(bottom: 16.kh),
                    ),
                  );
                }),
          ),
        ],
      ).paddingOnly(left: 16.kw, right: 16.kw, top: 32.kh),
    );
  }
}

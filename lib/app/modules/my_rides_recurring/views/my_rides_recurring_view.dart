//! contains recurring ride view in my rides
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/services/responsive_size.dart';

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
          Container(
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
                      style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
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
                              Get.find<ProfileController>().isSwitched.value
                                  ? ColorUtil.kSecondaryPinkMode
                                  : ColorUtil.kPrimary05,
                          activeTrackColor:
                              Get.find<ProfileController>().isSwitched.value
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                          trackOutlineWidth: const MaterialStatePropertyAll(0),
                          thumbColor: const MaterialStatePropertyAll(
                              ColorUtil.kWhiteColor),
                          trackOutlineColor: const MaterialStatePropertyAll(
                              ColorUtil.kNeutral1),
                        ),
                      ),
                    ),
                  ],
                ),
                const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 16.kh),
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10.kh,
                          width: 10.kw,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kGreenColor),
                        ).paddingOnly(right: 8.kw),
                        Expanded(
                          child: Text(
                            '1100 McIntosh St, Regina',
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kBlack02),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 30.kh),
                    Positioned(
                      top: 27.kh,
                      child: Row(
                        children: [
                          Container(
                            height: 10.kh,
                            width: 10.kw,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorUtil.kError4),
                          ).paddingOnly(right: 8.kw),
                          Text(
                            '681 Chrislea Rd, Woodbridge',
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kBlack02),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10.kh,
                      left: 4.5.kw,
                      child: Container(
                        height: 28.kh,
                        width: 1.kw,
                        color: ColorUtil.kBlack04,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 8.kh),
                const GreenPoolDivider().paddingOnly(top: 8.kh, bottom: 16.kh),
                Text(
                  "Rider Details",
                  style: TextStyleUtil.k14Bold(),
                ).paddingOnly(bottom: 16.kh),
              ],
            ),
          ),
        ],
      ).paddingOnly(left: 16.kw, right: 16.kw, top: 32.kh),
    );
  }
}

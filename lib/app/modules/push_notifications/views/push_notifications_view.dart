import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../profile/controllers/profile_controller.dart';
import '../controllers/push_notifications_controller.dart';

class PushNotificationsView extends GetView<PushNotificationsController> {
  const PushNotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text('Notifications'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Push notifications',
              style: TextStyleUtil.k18Bold(),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trips',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.isChecked[0].value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.setChecked(0);
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Alerts',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.isChecked[1].value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.setChecked(1);
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payments',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.isChecked[2].value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.setChecked(2);
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.isChecked[3].value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.setChecked(3);
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Offers',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<ProfileController>().isSwitched.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kPrimary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.isChecked[4].value,
                      activeColor:
                          Get.find<ProfileController>().isSwitched.value
                              ? ColorUtil.kPrimary3PinkMode
                              : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.setChecked(4);
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

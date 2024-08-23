import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/push_notifications_controller.dart';

class PushNotificationsView extends GetView<PushNotificationsController> {
  const PushNotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  GreenPoolAppBar(
          title: Text(Strings.notifications),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.pushNotifications,
              style: TextStyleUtil.k18Bold(),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.trips,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.trips.value,
                      activeColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.trips.value = value!;
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
                  Strings.alerts,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.alerts.value,
                      activeColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.alerts.value = value!;
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
                  Strings.payments,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.payments.value,
                      activeColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.payments.value = value!;
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
                  Strings.transactions,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.transactions.value,
                      activeColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.transactions.value = value!;
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
                  Strings.offers,
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                ),
                SizedBox(
                  height: 18.kh,
                  width: 18.kw,
                  child: Obx(
                    () => Checkbox(
                      side: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                      ),
                      splashRadius: 4.kh,
                      value: controller.offers.value,
                      activeColor: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kPrimary01,
                      onChanged: (value) {
                        controller.offers.value = value!;
                      },
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 16.kh),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () {
                controller.notificationPreferencesAPI();
              },
              label: Strings.save,
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

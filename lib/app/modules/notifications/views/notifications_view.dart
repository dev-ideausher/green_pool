import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            height: 74.kh,
            decoration: BoxDecoration(
                color: ColorUtil.kWhiteColor,
                borderRadius: BorderRadius.circular(8.kh)),
            padding: EdgeInsets.symmetric(horizontal: 8.kw, vertical: 16.kh),
            child: Row(
              children: [
                Container(
                  width: 8.kw,
                  height: 8.kh,
                  decoration: BoxDecoration(
                      color: Get.find<HomeController>().isSwitched.value
                          ? ColorUtil.kPrimaryPinkMode
                          : ColorUtil.kPrimary01,
                      shape: BoxShape.circle),
                ).paddingOnly(right: 8.kw),
                Expanded(
                    child: Text(
                  'Your ride has been published successfully !',
                  style: TextStyleUtil.k14Regular(),
                )),
                const Expanded(child: SizedBox()),
                Text(
                  '1h ago',
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16.kw);
        },
      ).paddingOnly(top: 32.kh),
    );
  }
}

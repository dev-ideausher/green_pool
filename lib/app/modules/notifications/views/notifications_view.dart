import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.notifications),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : ListView.builder(
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final notification = controller.notifications[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.kh),
                    decoration: BoxDecoration(color: ColorUtil.kWhiteColor, borderRadius: BorderRadius.circular(8.kh)),
                    padding: EdgeInsets.symmetric(horizontal: 8.kw, vertical: 16.kh),
                    child: ListTile(
                      leading: Container( height: 8.kh, width: 8.kh ,decoration:  BoxDecoration(color: Get.find<HomeController>().isPinkModeOn.value ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01, shape: BoxShape.circle),),
                      title: Text(notification.title ?? '', style: TextStyleUtil.k14Regular()),
                      subtitle: Text(notification.body ?? ''),
                      trailing: Text(
                        GpUtil.getAgoTime(notification.createdAt),
                        style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
                      ),
                    ).paddingOnly(right: 8.kw),
                  ).paddingSymmetric(horizontal: 16.kw);
                },
              ).paddingOnly(top: 32.kh),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/route_widget.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:green_pool/app/utils/date_utils.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../components/gp_progress.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/previous_rides_controller.dart';

class PreviousRidesView extends GetView<PreviousRidesController> {
  const PreviousRidesView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_driverHistory.tr),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const GpProgress()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.driverName.value,
                      style: TextStyleUtil.k20Heading600(),
                    ),
                    24.kheightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Tabs(
                          icon: Icon(Icons.check_circle,
                              color: ColorUtil.kPrimary01, size: 24.kh),
                          title: LocaleKeys.app_ridesCompleted.tr,
                          percentage: controller.driverHist.value.data
                                  ?.statistics?.completedPercentage
                                  ?.toStringAsFixed(0) ??
                              "0",
                        ),
                        Tabs(
                          icon: Icon(
                            Icons.not_interested,
                            color: ColorUtil.kError3,
                            size: 24.kh,
                          ),
                          title: LocaleKeys.app_cancelledRide.tr,
                          percentage: controller.driverHist.value.data
                                  ?.statistics?.cancelledPercentage
                                  ?.toStringAsFixed(0) ??
                              "0",
                        ),
                      ],
                    ),
                    24.kheightBox,
                    const GreenPoolDivider(),
                    24.kheightBox,
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              controller.driverHist.value.data?.rides?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            final data =
                                controller.driverHist.value.data?.rides?[index];
                            final isRideCancelled = controller.driverHist.value
                                    .data?.rides?[index]?.status ==
                                "cancelled";
                            return Container(
                              padding: EdgeInsets.all(16.kw),
                              decoration: BoxDecoration(
                                  color: ColorUtil.kWhiteColor,
                                  borderRadius: BorderRadius.circular(12.kh),
                                  border:
                                      Border.all(color: ColorUtil.kBlack07)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateTimeUtils.getTimeAMPM(data?.time ??
                                        LocaleKeys.app_defaultDate.tr),
                                    style: TextStyleUtil.k16Medium(),
                                  ),
                                  Row(
                                    children: [
                                      CommonImageView(
                                        svgPath:
                                            ImageConstant.svgIconCalendarTime,
                                      ),
                                      6.kwidthBox,
                                      Text(
                                        DateTimeUtils.dateMonthYear(
                                            data?.date ??
                                                LocaleKeys.app_defaultDate),
                                        style: TextStyleUtil.k14Regular(),
                                      ),
                                    ],
                                  ),
                                  8.kheightBox,
                                  const GreenPoolDivider(),
                                  RouteWidget(
                                      needPickUp: false,
                                      origin: data?.origin?.name ?? "",
                                      stop1: "",
                                      stop2: "",
                                      destination:
                                          data?.destination?.name ?? ""),
                                  const GreenPoolDivider(),
                                  8.kheightBox,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.kh, horizontal: 16.kw),
                                    decoration: BoxDecoration(
                                        color: isRideCancelled
                                            ? ColorUtil.kError1
                                            : isPinkModeOn
                                                ? ColorUtil.kSecondaryPinkMode
                                                : ColorUtil.kSecondary07,
                                        borderRadius:
                                            BorderRadius.circular(8.kh)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          isRideCancelled
                                              ? Icons.block
                                              : Icons.check,
                                          size: 20.kh,
                                          color: ColorUtil.kBlack01,
                                        ).paddingOnly(right: 8.kw),
                                        Text(
                                          isRideCancelled
                                              ? LocaleKeys.app_cancelled.tr
                                              : LocaleKeys.app_completed.tr,
                                          style: TextStyleUtil.k14Regular(
                                              color: ColorUtil.kBlack01),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ).paddingOnly(bottom: 8.kh);
                          }),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
        ));
  }
}

class Tabs extends StatelessWidget {
  final Icon icon;
  final String title, percentage;
  const Tabs({
    super.key,
    required this.icon,
    required this.title,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyleUtil.k14Semibold()),
        4.kheightBox,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.kw, vertical: 4.kh),
          decoration: BoxDecoration(
            color: ColorUtil.kPrimary07,
            borderRadius: BorderRadius.circular(16.kh),
          ),
          child: Row(
            children: [
              icon,
              4.kwidthBox,
              Text(
                "$percentage %",
                style: TextStyleUtil.k14Semibold(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

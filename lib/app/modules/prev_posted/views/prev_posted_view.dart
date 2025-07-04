import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/route_widget.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/gp_progress.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../constants/image_constant.dart';
import '../../../services/text_style_util.dart';
import '../../../utils/date_utils.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/prev_posted_controller.dart';

class PrevPostedView extends GetView<PrevPostedController> {
  const PrevPostedView({super.key});
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_postedRides.tr),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const GpProgress()
            : controller.prevRides.value.data?.data?.isEmpty ?? false
                ? Center(
                    child: Text(
                      LocaleKeys.app_noPastRidePostingsFound.tr,
                      style: TextStyleUtil.k20Heading600(),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 12.kh, bottom: 32.kh),
                    itemCount:
                        controller.prevRides.value.data?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final ride =
                          controller.prevRides.value.data?.data?[index];
                      return GestureDetector(
                        onTap: () {
                          controller.toEditRide(ride);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.kh),
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.kh, vertical: 4.kh),
                          decoration: BoxDecoration(
                              color: ColorUtil.kWhiteColor,
                              borderRadius: BorderRadius.circular(8.kh),
                              border: Border.all(
                                  width: 0.3.kh, color: ColorUtil.kNeutral10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //time or recurring
                              Text(
                                  ride?.isRecurring ?? false
                                      ? LocaleKeys.app_recurringTrip.tr
                                      : DateTimeUtils.convertUtcToLocal(
                                          ride?.time ??
                                              "2024-04-05T00:00:00.000Z"),
                                  style: TextStyleUtil.k16Bold()),
                              //date
                              8.kheightBox,
                              Visibility(
                                visible: ride?.isRecurring == false,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImageConstant.svgIconCalendarTime,
                                      colorFilter: ColorFilter.mode(
                                          isPinkModeOn
                                              ? ColorUtil.kPrimary3PinkMode
                                              : ColorUtil.kSecondary01,
                                          BlendMode.srcIn),
                                    ).paddingOnly(right: 4.kw),
                                    Text(
                                      '${DateTimeUtils.getDateFormat(ride?.date ?? "2024-04-05T00:00:00.000Z")}  ${DateTimeUtils.convertUtcToLocal(ride?.time ?? "2024-04-05T00:00:00.000Z")}',
                                      style: TextStyleUtil.k12Regular(
                                          color: ColorUtil.kBlack03),
                                    ),
                                  ],
                                ),
                              ),

                              //
                              8.kheightBox,
                              const GreenPoolDivider(),
                              RouteWidget(
                                origin: ride?.origin?.name ?? "Origin",
                                stop1: ride?.stops?[0]?.name ?? "",
                                stop2: ride?.stops?[1]?.name ?? "",
                                destination:
                                    ride?.destination?.name ?? "Destination",
                                needPickUp: false,
                              ),
                              const GreenPoolDivider(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

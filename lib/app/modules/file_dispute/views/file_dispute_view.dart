import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/file_dispute/views/submit_dispute.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../profile/controllers/profile_controller.dart';
import '../controllers/file_dispute_controller.dart';

class FileDisputeView extends GetView<FileDisputeController> {
  const FileDisputeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text('File Dispute'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16.kh),
                  decoration: BoxDecoration(
                      color: ColorUtil.kWhiteColor,
                      borderRadius: BorderRadius.circular(8.kh),
                      border: Border(
                          bottom: BorderSide(
                              color: ColorUtil.kNeutral7, width: 2.kh))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '10:30 am',
                            style: TextStyleUtil.k16Bold(),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtil.kPrimary01),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(12.kh),
                                    child: Image.asset(
                                      ImageConstant.pngPassenger1,
                                    ),
                                  ),
                                ),
                              ).paddingOnly(right: 4.kw),
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtil.kPrimary01),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(12.kh),
                                    child: Image.asset(
                                      ImageConstant.pngPassenger2,
                                    ),
                                  ),
                                ),
                              ).paddingOnly(right: 4.kw),
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtil.kPrimary01),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(12.kh),
                                    child: Image.asset(
                                      ImageConstant.pngPassenger3,
                                    ),
                                  ),
                                ),
                              ).paddingOnly(right: 4.kw),
                              Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorUtil.kPrimary01),
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(12.kh),
                                    child: Image.asset(
                                      ImageConstant.pngPassenger4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingOnly(bottom: 8.kh),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageConstant.svgIconCalendarTime,
                            colorFilter: ColorFilter.mode(
                                Get.find<ProfileController>().isSwitched.value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ).paddingOnly(right: 4.kw),
                          Text(
                            '07 November 2023',
                            style: TextStyleUtil.k12Regular(
                                color: ColorUtil.kBlack03),
                          ),
                        ],
                      ).paddingOnly(bottom: 8.kh),
                      Container(
                        width: 100.w,
                        height: 1.kh,
                        color: ColorUtil.kBlack07,
                      ).paddingOnly(bottom: 16.kh),
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
                              Text(
                                '1100 McIntosh St, Regina',
                                style: TextStyleUtil.k14Regular(
                                    color: ColorUtil.kBlack02),
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
                      Container(
                        width: 100.w,
                        height: 1.kh,
                        color: ColorUtil.kBlack07,
                      ).paddingOnly(bottom: 16.kh),
                      GreenPoolButton(
                        onPressed: () => Get.to(const SubmitDispute()),
                        isBorder: true,
                        height: 40.kh,
                        padding: EdgeInsets.all(8.kh),
                        fontSize: 14.kh,
                        borderColor:
                            Get.find<ProfileController>().isSwitched.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                        labelColor:
                            Get.find<ProfileController>().isSwitched.value
                                ? ColorUtil.kPrimary3PinkMode
                                : ColorUtil.kSecondary01,
                        label: 'File Dispute',
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 16.kh);
              },
            ).paddingOnly(top: 32.kh),
          ),
        ],
      ).paddingSymmetric(horizontal: 16.kw),
    );
  }
}

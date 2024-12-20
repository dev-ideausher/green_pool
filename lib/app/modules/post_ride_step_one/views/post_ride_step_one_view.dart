import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../res/strings.dart';
import '../../../services/custom_button.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/post_ride_step_one_controller.dart';

class PostRideStepOneView extends GetView<PostRideStepOneController> {
  const PostRideStepOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.postARide),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichTextHeading(text: Strings.pickup).paddingOnly(top: 12.kh),
                GreenPoolTextField(
                  hintText: Strings.enterOrigin,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveStatePostRideView();
                  },
                  onTap: () {
                    controller.moveToSetOrigin();
                  },
                  controller: controller.originTextController,
                  readOnly: true,
                  prefix: Icon(
                    Icons.location_on,
                    size: 24.kh,
                    color: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  /*suffix: controller.originTextController.value.text.isNotEmpty
                      ? InkWell(
                          onTap: () => controller.removeOrigin(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),*/
                ).paddingOnly(top: 8.kh, bottom: 30.kh),
                RichTextHeading(text: Strings.destination),
                GreenPoolTextField(
                  hintText: Strings.enterAdestination,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveStatePostRideView();
                  },
                  onTap: () {
                    controller.moveToSetDestination();
                  },
                  controller: controller.destinationTextController,
                  readOnly: true,
                  prefix: Icon(
                    Icons.location_on,
                    size: 24.kh,
                    color: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  /*suffix: controller.destinationTextController.value.text.isNotEmpty
                      ? InkWell(
                          onTap: () => controller.removeDestination(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),*/
                ).paddingOnly(top: 8.kh, bottom: 16.kh),
                Visibility(
                  visible: controller.isDestinationAdded.value,
                  child: Text(
                    Strings.addStops,
                    style: TextStyleUtil.k14Semibold(),
                  ),
                ),
                //stop1
                Visibility(
                  visible: controller.isDestinationAdded.value,
                  child: GreenPoolTextField(
                    hintText: Strings.addStops,
                    keyboardType: TextInputType.streetAddress,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorUtil.kBlack06),
                        borderRadius: BorderRadius.circular(8.kh)),
                    onTap: () {
                      controller.moveToSetStop1();
                    },
                    controller: controller.stop1TextController,
                    readOnly: true,
                    prefix: Icon(
                      Icons.add_circle,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    ),
                    suffix: controller.isStop1Added.value
                        ? InkWell(
                            onTap: () => controller.removeStop1(),
                            child: const Icon(Icons.cancel))
                        : SvgPicture.asset(
                            ImageConstant.svgIconReorder,
                            colorFilter: ColorFilter.mode(
                                Get.find<HomeController>().isPinkModeOn.value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ),
                  ).paddingOnly(top: 8.kh, bottom: 16.kh),
                ),
                //stop2
                Visibility(
                  visible: controller.isStop1Added.value,
                  child: GreenPoolTextField(
                    hintText: Strings.addStops,
                    keyboardType: TextInputType.streetAddress,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorUtil.kBlack06),
                        borderRadius: BorderRadius.circular(8.kh)),
                    onTap: () {
                      controller.moveToSetStop2();
                    },
                    controller: controller.stop2TextController,
                    readOnly: true,
                    prefix: Icon(
                      Icons.add_circle,
                      size: 20.kh,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kSecondary01,
                    ),
                    suffix: controller.isStop2Added.value
                        ? InkWell(
                            onTap: () => controller.removeStop2(),
                            child: const Icon(Icons.cancel))
                        : SvgPicture.asset(
                            ImageConstant.svgIconReorder,
                            colorFilter: ColorFilter.mode(
                                Get.find<HomeController>().isPinkModeOn.value
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ),
                  ).paddingOnly(top: 8.kh, bottom: 16.kh),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => GreenPoolButton(
                        onPressed: () => controller.moveToStepTwo(),
                        padding: const EdgeInsets.all(0),
                        isActive: controller.isActive.value,
                        label: Strings.next,
                        fontSize: 14.kh,
                        width: 120.kw,
                        height: 40.kh,
                      ).paddingSymmetric(vertical: 40.kh),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                onPressed: () {
                  controller.swapTextFields();
                },
                highlightColor: ColorUtil.kPrimary03,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(ColorUtil.kPrimary01),
                ),
                padding: EdgeInsets.all(4.kh),
                icon: Icon(
                  Icons.swap_vert_rounded,
                  size: 28.kh,
                  color: ColorUtil.kSecondary01,
                )).paddingOnly(right: 40.kw, top: 96.kh).animate().flip(),
          ),
        ],
      ),
    );
  }
}
/**
 Align(
                  alignment: Alignment.center,
                  child: IconButton(
                          onPressed: () {
                            controller.swapTextFields();
                          },
                          highlightColor: ColorUtil.kPrimary03,
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(ColorUtil.kPrimary01),
                          ),
                          icon: const Icon(Icons.swap_vert_sharp))
                      .animate()
                      .flip(),
                ),
 */

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/profile_setup/views/setup_user.dart';
import 'package:green_pool/app/modules/profile_setup/views/setup_vehicle.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/text_style_util.dart';
import '../controllers/profile_setup_controller.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //         onTap: () => Get.back(),
              //         child: SvgPicture.asset(ImageConstant.svgIconBack30),
              //         )
              //     .paddingOnly(top: 16.kh, bottom: 8.kh),
              Text(
                'Profile Setup',
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(bottom: 4.kh),
              Text(
                'Enter your profile details',
                style: TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
              ).paddingOnly(bottom: 24.kh),
              TabBar(
                  onTap:
                      (index) {}, //TODO: have to take index from here and if pressed proceed on user detials then the index should be increased by one so that we land on vehicle details
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(4.kh),
                  unselectedLabelStyle:
                      TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                  labelStyle:
                      TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                  overlayColor: MaterialStatePropertyAll(
                      ColorUtil.kSecondary01.withOpacity(0.05)),
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: ColorUtil.kSecondary01, width: 2.kh),
                  ),
                  labelColor: ColorUtil.kSecondary01,
                  tabs: const [
                    Tab(
                      child: Text(
                        'User Details',
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Vehicle Details',
                      ),
                    ),
                  ]),
              const Expanded(
                child: TabBarView(
                  children: [SetupUser(), SetupVehicle()],
                ),
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 16.kh),
      ),
    );
  }
}

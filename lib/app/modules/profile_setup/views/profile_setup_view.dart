import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/profile_setup/views/setup_user.dart';
import 'package:green_pool/app/modules/profile_setup/views/setup_vehicle.dart';
import 'package:green_pool/app/modules/rider_profile_setup/views/rider_profile_setup_view.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../services/text_style_util.dart';
import '../controllers/profile_setup_controller.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Setup',
              style: TextStyleUtil.k32Heading700(),
            ).paddingOnly(bottom: 4.kh, top: 42.kh),
            Text(
              'Enter your profile details',
              style: TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
            ).paddingOnly(bottom: 24.kh),
            TabBar(
                onTap: (index) {},
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller.tabBarController,
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
                tabs:  [
                  Tab(
                    child: Text(
                      Strings.userDetails,
                    ),
                  ),
                  Tab(
                    child: Text(
                      Strings.vehicleDetails,
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(
                controller: controller.tabBarController,
                children: const [SetupUser(), SetupVehicle()],
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: 16.kh),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/profile/controllers/profile_controller.dart';
import '../services/colors.dart';

class GpProgress extends StatelessWidget {
  const GpProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Get.find<ProfileController>().isSwitched.value ? ColorUtil.kPrimary3PinkMode : ColorUtil.kPrimary01,
    ));
  }
}

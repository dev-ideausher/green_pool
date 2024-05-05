import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';
import '../services/colors.dart';

class GpProgress extends StatelessWidget {
  const GpProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: Get.find<HomeController>().isPinkModeOn.value
          ? ColorUtil.kPrimary3PinkMode
          : ColorUtil.kPrimary01,
    ));
  }
}

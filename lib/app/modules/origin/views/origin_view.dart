import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/origin_controller.dart';

class OriginView extends GetView<OriginController> {
  const OriginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text('Origin'),
        ),
        body: Column(
          children: [
            GreenPoolTextField(
              hintText: 'Enter origin address',
              onTap: () {
                Get.toNamed(Routes.ORIGIN);
              },
              autofocus: true,
              enabled: true,
              prefix: Icon(
                Icons.location_on,
                size: 24.kh,
                color: Get.find<ProfileController>().isSwitched.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kSecondary01,
              ),
            ).paddingOnly(top: 32.kh, bottom: 16.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

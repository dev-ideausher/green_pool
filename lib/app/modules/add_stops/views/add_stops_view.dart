import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/add_stops_controller.dart';

class AddStopsView extends GetView<AddStopsController> {
  const AddStopsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text('Add Stops'),
        ),
        body: Column(
          children: [
            GreenPoolTextField(
              hintText: 'Add a stop',
              onTap: () {},
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

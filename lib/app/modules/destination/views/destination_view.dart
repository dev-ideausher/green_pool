import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/destination_controller.dart';

class DestinationView extends GetView<DestinationController> {
  const DestinationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text("Destination"),
        ),
        body: Column(
          children: [
            GreenPoolTextField(
              hintText: 'Enter destination address',
              autofocus: true,
              onchanged: (value) {
                controller.setSessionToken();
              },
              enabled: true,
              prefix: Icon(
                Icons.location_on,
                size: 24.kh,
                color: Get.find<ProfileController>().isSwitched.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kSecondary01,
              ),
            ).paddingOnly(top: 32.kh, bottom: 16.kh),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.destinationList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            controller.destinationList[index]['description']),
                        onTap: () async {
                          await controller.getLatLong(
                              controller.destinationList[index]['place_id']);
                        },
                      );
                    }),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

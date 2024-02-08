import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/origin_controller.dart';

class OriginView extends GetView<OriginController> {
  const OriginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: controller.isOrigin.value
              ? const Text('Origin')
              : const Text('Destination'),
        ),
        body: Column(
          children: [
            Obx(
              () => GreenPoolTextField(
                hintText: controller.isOrigin.value
                    ? 'Enter origin address'
                    : 'Enter destination address',
                controller: controller.originController,
                onchanged: (value) {
                  controller.setSessionToken();
                },
                autofocus: true,
                prefix: Icon(
                  Icons.location_on,
                  size: 24.kh,
                  color: Get.find<ProfileController>().isSwitched.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ).paddingOnly(top: 32.kh, bottom: 16.kh),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.addressSugestionList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.kh, color: ColorUtil.kNeutral7)),
                            borderRadius: BorderRadius.circular(8.kh)),
                        child: ListTile(
                          title: Text(controller.addressSugestionList[index]
                              ['description']),
                          onTap: () async {
                            await controller.getLatLong(controller
                                .addressSugestionList[index]['place_id']);

                            await controller.setLocationData(controller
                                .addressSugestionList[index]['place_id']);
                          },
                        ),
                      );
                    }),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

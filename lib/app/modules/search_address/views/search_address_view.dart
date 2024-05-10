import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/gp_progress.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../../origin/controllers/origin_controller.dart';
import '../controllers/search_address_controller.dart';

class SearchAddressView extends GetView<SearchAddressController> {
  const SearchAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: controller.locationValues.name == LocationValues.origin.name ||
                  controller.locationValues.name ==
                      LocationValues.findRideOrigin.name
              ? const Text('Origin')
              : controller.locationValues.name ==
                          LocationValues.destination.name ||
                      controller.locationValues.name ==
                          LocationValues.findRideDestination.name
                  ? const Text('Destination')
                  : const Text('Add Stops'),
        ),
        body: Column(
          children: [
            Obx(
              () => GreenPoolTextField(
                hintText: controller.locationValues.name ==
                            LocationValues.origin.name ||
                        controller.locationValues.name ==
                            LocationValues.findRideOrigin.name
                    ? 'Enter origin address'
                    : controller.locationValues.name ==
                                LocationValues.destination.name ||
                            controller.locationValues.name ==
                                LocationValues.findRideDestination.name
                        ? 'Enter destination address'
                        : controller.locationValues.name ==
                                LocationValues.addStop1.name
                            ? 'Add Stop 1'
                            : 'Add stop 2',
                controller: controller.originController,
                onchanged: (value) {
                  controller.setSessionToken();
                },
                autofocus: true,
                prefix: Icon(
                  Icons.location_on,
                  size: 24.kh,
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ).paddingOnly(top: 32.kh, bottom: 16.kh),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const GpProgress()
                    : ListView.builder(
                        itemCount: controller.addressSugestionList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.kh,
                                        color: ColorUtil.kNeutral7)),
                                borderRadius: BorderRadius.circular(8.kh)),
                            child: ListTile(
                              title: Text(controller.addressSugestionList[index]
                                  ['description']),
                              onTap: () async {
                                await controller.setLocationData(controller
                                    .addressSugestionList[index]['place_id']);
                                // Get.back(
                                //     result: controller.postRideModel.value);
                                Get.back();
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

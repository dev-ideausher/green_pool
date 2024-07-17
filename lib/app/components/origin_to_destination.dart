import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class OriginToDestination extends StatelessWidget {
  final String origin, destination;
  final bool needPickupText;
  final String stop1, stop2;

  const OriginToDestination(
      {super.key,
      required this.origin,
      required this.destination,
      required this.needPickupText,
      this.stop1 = "",
      this.stop2 = ""});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10.kh,
          left: 4.5.kw,
          child: Container(
            // height: 84.kh,
            height: stop1 == "" && stop2 == ""
                ? 28.kh
                : stop1 != "" && stop2 != ""
                    ? 84.kh
                    : 56.kh,
            width: 1.kw,
            color: ColorUtil.kBlack04,
          ),
        ),
        Row(
          children: [
            Container(
              height: 10.kh,
              width: 10.kw,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorUtil.kGreenColor),
            ).paddingOnly(right: 8.kw),
            needPickupText
                ? Text(
                    'Pick up: ',
                    style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack02),
                  ).paddingOnly(right: 8.kw)
                : const SizedBox(),
            Expanded(
              child: Text(
                origin,
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ).paddingOnly(
            bottom: stop1 == "" && stop2 == ""
                ? 30.kh
                : stop1 != "" && stop2 != ""
                    ? 90.kh
                    : 60.kh),
        // ).paddingOnly(bottom: 30),
        Visibility(
          visible: stop1 != "",
          child: Positioned(
            top: 27.kh,
            child: Row(
              children: [
                Container(
                  height: 10.kh,
                  width: 10.kw,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: ColorUtil.kYellowColor),
                ).paddingOnly(right: 8.kw),
                needPickupText
                    ? Text(
                        'Stop 1: ',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack02),
                      ).paddingOnly(right: 8.kw)
                    : const SizedBox(),
                Text(
                  // '681 Chrislea Rd, Woodbridge',
                  stop1 ?? "",
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: stop2 != "",
          child: Positioned(
            top: 54.kh,
            child: Row(
              children: [
                Container(
                  height: 10.kh,
                  width: 10.kw,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: ColorUtil.kYellowColor),
                ).paddingOnly(right: 8.kw),
                needPickupText
                    ? Text(
                        'Stop 2: ',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack02),
                      ).paddingOnly(right: 8.kw)
                    : const SizedBox(),
                Text(
                  // '681 Chrislea Rd, Woodbridge',
                  stop2 ?? "",
                  style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: stop1 == "" && stop2 == ""
              ? 27.kh
              : stop1 != "" && stop2 != ""
                  ? 81.kh
                  : 54.kh,
          child: Row(
            children: [
              Container(
                height: 10.kh,
                width: 10.kw,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorUtil.kError4),
              ).paddingOnly(right: 8.kw),
              needPickupText
                  ? Text(
                      'Drop off: ',
                      style:
                          TextStyleUtil.k14Semibold(color: ColorUtil.kBlack02),
                    ).paddingOnly(right: 8.kw)
                  : const SizedBox(),
              Text(
                // '681 Chrislea Rd, Woodbridge',
                destination,
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
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
            height: stop1 == "" && stop2 == ""
                ? 48.kh
                : stop1 != "" && stop2 != ""
                    ? 128.kh
                    : 88.kh,
            width: 1.kw,
            color: ColorUtil.kBlack04,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.kh,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.kh,
                        width: 10.kw,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtil.kGreenColor),
                      ).paddingOnly(right: 8.kw),
                      // needPickupText
                      //     ?
                      Text(
                        'Pick up: ',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack02),
                      ).paddingOnly(right: 4.kw)
                      // : const SizedBox(),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      origin,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                      softWrap: true,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 4.kh),
            ),
            Visibility(
              visible: stop1 != "",
              child: SizedBox(
                height: 40.kh,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10.kh,
                          width: 10.kw,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kYellowColor),
                        ).paddingOnly(right: 8.kw),
                        // needPickupText
                        //     ?
                        Text(
                          'Stop 1:   ',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack02),
                        ).paddingOnly(right: 4.kw)
                        // : const SizedBox(),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        stop1,
                        style:
                            TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 4.kh),
            Visibility(
              visible: stop2 != "",
              child: SizedBox(
                height: 40.kh,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10.kh,
                          width: 10.kw,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kYellowColor),
                        ).paddingOnly(right: 8.kw),
                        // needPickupText
                        //     ?
                        Text(
                          'Stop 2:   ',
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kBlack02),
                        ).paddingOnly(right: 4.kw)
                        // : const SizedBox(),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        stop2,
                        style:
                            TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(bottom: 4.kh),
            SizedBox(
              height: 40.kh,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 10.kh,
                        width: 10.kw,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: ColorUtil.kError4),
                      ).paddingOnly(right: 8.kw),
                      // needPickupText
                      //     ?
                      Text(
                        'Drop off:',
                        style: TextStyleUtil.k14Semibold(
                            color: ColorUtil.kBlack02),
                      ).paddingOnly(right: 4.kw)
                      // : const SizedBox(),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      destination,
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

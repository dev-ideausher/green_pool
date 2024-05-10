import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class OriginToDestination extends StatelessWidget {
  final String origin, destination;
  final bool needPickupText;

  const OriginToDestination(
      {super.key,
      required this.origin,
      required this.destination,
      required this.needPickupText});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        ).paddingOnly(bottom: 30.kh),
        Positioned(
          top: 27.kh,
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
        Positioned(
          top: 10.kh,
          left: 4.5.kw,
          child: Container(
            height: 28.kh,
            width: 1.kw,
            color: ColorUtil.kBlack04,
          ),
        ),
      ],
    );
  }
}

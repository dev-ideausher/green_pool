import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/cp_timeline_tile.dart';
import 'package:green_pool/generated/locales.g.dart';

class RouteWidget extends StatelessWidget {
  final String origin, stop1, stop2, destination;
  final bool needPickUp;
  const RouteWidget(
      {super.key,
      required this.origin,
      required this.stop1,
      required this.stop2,
      required this.destination,
      required this.needPickUp});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CpTimelineTile(
            isFirst: true,
            isLast: false,
            isPast: false,
            title: origin,
            prefixText: "${LocaleKeys.app_pickup.tr}: ",
            needPickUpTxt: needPickUp),
        Visibility(
          visible: stop1 != "",
          child: CpTimelineTile(
              isFirst: false,
              isLast: false,
              isPast: false,
              title: stop1,
              prefixText: LocaleKeys.app_stop_1.tr,
              needPickUpTxt: needPickUp),
        ),
        Visibility(
          visible: stop2 != "",
          child: CpTimelineTile(
              isFirst: false,
              isLast: false,
              isPast: false,
              title: stop2,
              prefixText: LocaleKeys.app_stop_2.tr,
              needPickUpTxt: needPickUp),
        ),
        CpTimelineTile(
            isFirst: false,
            isLast: true,
            isPast: false,
            title: destination,
            prefixText: "${LocaleKeys.app_destination.tr}: ",
            needPickUpTxt: needPickUp),
      ],
    );
  }
}

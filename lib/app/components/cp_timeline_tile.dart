import 'package:flutter/material.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class CpTimelineTile extends StatelessWidget {
  final bool isFirst, isLast, isPast;
  final String title;
  final String? prefixText;
  final bool needPickUpTxt;
  const CpTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast,
      required this.title,
      this.prefixText,
      required this.needPickUpTxt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        //line decoration
        beforeLineStyle:
            LineStyle(color: ColorUtil.kBlack02, thickness: 0.6.kh),
        //icon decoration
        indicatorStyle: IndicatorStyle(
          color: ColorUtil.kGreenColor,
          indicator: isFirst
              ? Icon(Icons.circle, color: ColorUtil.kGreenColor, size: 12.kw)
              : isLast
                  ? Icon(Icons.circle, color: ColorUtil.kError2, size: 12.kw)
                  : Icon(Icons.circle,
                      color: ColorUtil.kYellowColor, size: 12.kw),
        ),
        endChild: EventCard(
          title: title,
          prefixText: prefixText,
          needPickUpTxt: needPickUpTxt,
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String? prefixText;
  final bool needPickUpTxt;
  const EventCard(
      {super.key,
      required this.title,
      this.prefixText,
      required this.needPickUpTxt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.kh),
      child: Row(
        children: [
          Visibility(
            visible: needPickUpTxt,
            child: Text(
              prefixText ?? "",
              style: TextStyleUtil.k14Semibold(),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack02),
              // maxLines: 1,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

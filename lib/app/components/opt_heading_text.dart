import 'package:flutter/material.dart';

import '../res/strings.dart';
import '../services/colors.dart';
import '../services/text_style_util.dart';

class OptFieldHeading extends StatelessWidget {
  const OptFieldHeading({
    super.key,
    required this.heading,
  });

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: heading,
            style: TextStyleUtil.k14Semibold(),
          ),
          TextSpan(
            text: Strings.optional,
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
          ),
        ],
      ),
    );
  }
}
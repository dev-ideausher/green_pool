import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class RichTextHeading extends StatelessWidget {
  final String text;
  const RichTextHeading({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyleUtil.k14Semibold(),
          ),
          TextSpan(
            text: '*',
            style: TextStyleUtil.k14Regular(color: ColorUtil.kError3),
          ),
        ],
      ),
    ).paddingOnly(bottom: 8.kh);
  }
}

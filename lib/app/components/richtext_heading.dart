import 'package:flutter/material.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class RichTextHeading extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const RichTextHeading({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: style ?? TextStyleUtil.k14Semibold(),
          ),
          TextSpan(
            text: '*',
            style: TextStyleUtil.k14Regular(color: ColorUtil.kError3),
          ),
        ],
      ),
    );
  }
}

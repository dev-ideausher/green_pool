import 'package:flutter/material.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';

class GreenPoolDivider extends StatelessWidget {
  const GreenPoolDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 1.kh,
      color: ColorUtil.kBlack07,
    );
  }
}

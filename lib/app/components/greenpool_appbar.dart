import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../constants/image_constant.dart';
import '../services/text_style_util.dart';

class GreenPoolAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? appBarSize;
  final Widget? title, leading;
  final List<Widget>? actions;
  const GreenPoolAppBar({
    super.key,
    this.appBarSize,
    this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      titleTextStyle: TextStyleUtil.k18Bold(),
      toolbarHeight: appBarSize ?? 46.kh,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, //For iOS (dark icons)
      ),
      elevation: 0,
      actions: actions,
      leading: leading ??
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.all(8.kh),
              child: SvgPicture.asset(
                ImageConstant.svgIconBack,
                height: 24.kh,
                width: 24.kw,
              ),
            ),
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize ?? 46.kh);
}

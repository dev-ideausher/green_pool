import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../modules/home/controllers/home_controller.dart';
import 'colors.dart';
import 'text_style_util.dart';

class GreenPoolButton extends StatelessWidget {
  final bool isActive;
  final bool isBorder;
  final bool isLoading;
  final String? label;
  final double? width, fontSize, height, borderRadius, borderWidth;
  final Function()? onPressed;
  final Widget? child;
  final Color? color, borderColor, labelColor;
  final EdgeInsetsGeometry? padding;
  const GreenPoolButton({
    super.key,
    this.label,
    this.borderRadius,
    this.fontSize,
    required this.onPressed,
    this.width,
    this.color,
    this.child,
    this.height,
    this.isActive = true,
    this.isBorder = false,
    this.borderWidth,
    this.borderColor,
    this.isLoading = false,
    this.labelColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading || !isActive ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorUtil.kWhiteColor,
          surfaceTintColor: ColorUtil.kSecondary07,
          shadowColor: ColorUtil.kWhiteColor,
          minimumSize: Size(width ?? 343.kw, height ?? 56.kh),
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.kh),
          elevation: 0,
          backgroundColor: color ??
              (isBorder
                  ? Colors.transparent
                  : Get.find<HomeController>().isSwitched.value
                      ? (isActive
                          ? ColorUtil.kPrimaryPinkMode
                          : ColorUtil.kSecondaryPinkMode)
                      : (isActive
                          ? ColorUtil.kPrimary01
                          : ColorUtil.kPrimary06)),
          shape: RoundedRectangleBorder(
              side: isBorder
                  ? BorderSide(
                      color: borderColor ?? Colors.black,
                      width: borderWidth ?? 1.kh)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 100.kh)),
        ),
        child: isLoading
            ? isActive
                ? SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
                : SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: const CircularProgressIndicator(color: Colors.white),
                  )
            : child ??
                Text(
                  label ?? '',
                  style: TextStyleUtil.k16Semibold(
                      fontSize: fontSize ?? 16.kh,
                      color: isActive
                          ? labelColor ?? ColorUtil.kBlack01
                          : labelColor ?? ColorUtil.kBlack05),
                ),
      ),
    );
  }
}

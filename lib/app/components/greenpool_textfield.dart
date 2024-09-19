import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class GreenPoolTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hintText;
  final Color? fillColor, hintColor;
  final TextCapitalization textCapitalization;
  final bool? isSuffixNeeded;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final bool? obscureText, readOnly;
  final Function(String?)? onchanged, onSaved;
  final int? maxLines;
  final bool? enabled, autofocus;
  final Widget? prefix, suffix;
  final Function()? onTap, onPressedSuffix;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  const GreenPoolTextField(
      {super.key,
      this.validator,
      this.controller,
      this.maxLines,
      required this.hintText,
      this.obscureText,
      this.onchanged,
      this.enabled,
      this.suffix,
      this.prefix,
      this.onTap,
      this.autofocus,
      this.onPressedSuffix,
      this.readOnly,
      this.autovalidateMode,
      this.onSaved,
      this.keyboardType,
      this.fillColor,
      this.border,
      this.isSuffixNeeded,
      this.hintColor,
      this.textCapitalization = TextCapitalization.none,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      inputFormatters: inputFormatters,
      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack01),
      maxLines: maxLines ?? 1,
      onTap: onTap,
      cursorColor: ColorUtil.kBlack01,
      onChanged: onchanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: controller,
      onSaved: onSaved,
      obscureText: obscureText ?? false,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
        suffixIcon: isSuffixNeeded ?? true
            ? Padding(
                padding: EdgeInsets.only(right: 16.kw, left: 8.kw),
                child: IconButton(
                  icon: suffix ?? const SizedBox(),
                  onPressed: onPressedSuffix,
                ),
              )
            : const SizedBox(),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.kw, right: 8.kw, top: 1.kh),
          child: prefix,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 24.kh),
        prefixIconConstraints: BoxConstraints(minHeight: 24.kh),
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.kh, horizontal: 16.kw),
        hintText: hintText,
        fillColor: fillColor ?? ColorUtil.kGreyColor,
        filled: true,
        hintStyle: TextStyleUtil.k14Regular(
          color: hintColor ?? ColorUtil.kBlack03,
        ),
        enabledBorder: border ??
            UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.kh)),
        focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.kh)),
        disabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.kh)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorUtil.kError2),
          borderRadius: BorderRadius.circular(8.kh),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorUtil.kError2),
          borderRadius: BorderRadius.circular(8.kh),
        ),
      ),
    );
  }
}

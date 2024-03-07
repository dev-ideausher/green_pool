import 'package:flutter/material.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class GreenPoolTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hintText;
  // final String? initialValue;
  final bool? obscureText, readOnly;
  final Function(String?)? onchanged, onSaved;
  final int? maxLines;
  final bool? enabled, autofocus;
  final Widget? prefix, suffix;
  final Function()? onTap, onPressedSuffix;
  final AutovalidateMode? autovalidateMode;

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
      // this.initialValue,
      this.readOnly,
      this.autovalidateMode,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,

      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack01),
      maxLines: maxLines ?? 1,
      onTap: onTap,
      onChanged: onchanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: controller,
      onSaved: onSaved,
      obscureText: obscureText ?? false,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      keyboardType: TextInputType.name,
      // initialValue: initialValue,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 16.kw, left: 8.kw),
          child: IconButton(
            icon: suffix ?? const SizedBox(),
            onPressed: onPressedSuffix,
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.kw, right: 8.kw),
          child: prefix,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 24.kh),
        prefixIconConstraints: BoxConstraints(minHeight: 24.kh),
        contentPadding:
            EdgeInsets.symmetric(vertical: 16.kh, horizontal: 16.kw),
        hintText: hintText,
        fillColor: ColorUtil.kGreyColor,
        filled: true,
        hintStyle: TextStyleUtil.k14Regular(
          color: ColorUtil.kBlack03,
        ),
        enabledBorder: UnderlineInputBorder(
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

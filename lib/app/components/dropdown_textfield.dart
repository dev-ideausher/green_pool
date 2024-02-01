import 'package:flutter/material.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../services/colors.dart';
import '../services/text_style_util.dart';

class GreenPoolDropDown extends StatelessWidget {
  final String hintText;
  final Widget? suffix, prefix;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?)? onChanged;
  const GreenPoolDropDown(
      {super.key,
      required this.hintText,
      this.suffix,
      this.prefix,
      this.items,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(16.kw),
      elevation: 4,
      decoration: InputDecoration(
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
      items: items,
      onChanged: onChanged,
    );
  }
}

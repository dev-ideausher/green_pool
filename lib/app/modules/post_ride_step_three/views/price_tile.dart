import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';

class PriceTile extends StatelessWidget {
  final Function(String?)? onchanged;
  final String? trallingText;
  final String? Function(String?)? validator;
  final TextEditingController? txtController;
  final bool enabled;

  const PriceTile({Key? key, this.onchanged, this.trallingText, this.validator, this.enabled = false, this.txtController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 40.w,
            height: 10.h,
            child: GreenPoolTextField(
              enabled: enabled,
              hintText: '',
              isSuffixNeeded: false,
              keyboardType: const TextInputType.numberWithOptions(),
              onchanged: (val) {
                onchanged!(val);
              },
              validator: (v) => validator!(v),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: txtController,
              prefix: Text(
                '\$',
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack03,
                ),
              ),
            )).paddingOnly(right: 8.kw),
        Flexible(
          child: SizedBox(
            height: 10.h,
            child: Text(
              (trallingText ?? ""),
              textAlign: TextAlign.center,
              style: TextStyleUtil.k14Semibold(),
            ),
          ),
        ),
      ],
    );
  }
}

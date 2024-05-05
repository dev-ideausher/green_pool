import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text("Payment Method"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Cards",
              style: TextStyleUtil.k16Bold(),
            ).paddingOnly(top: 32.kh, bottom: 16.kh),
            SavedCardsTile(
                title: "Add Credit/Debit Card",
                path: ImageConstant.svgAddCard,
                onTap: () {
                  Get.toNamed(Routes.ADD_CARD);
                }),
            const Expanded(child: SizedBox()),
            GreenPoolButton(
              onPressed: () {},
              label: "Proceed",
            ).paddingSymmetric(vertical: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

class SavedCardsTile extends StatelessWidget {
  final String title, path;
  final Function() onTap;
  const SavedCardsTile({
    super.key,
    required this.title,
    required this.path,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68.kh,
      child: ListTile(
        tileColor: ColorUtil.kWhiteColor,
        onTap: onTap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
        title: Text(
          title,
          style: TextStyleUtil.k14Semibold(),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: Container(
          height: 48.kh,
          width: 48.kw,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtil.kBlack07,
              borderRadius: BorderRadius.circular(12.kh)),
          child: CommonImageView(
            svgPath: path,
            height: 24.kh,
          ),
        ),
        trailing: CommonImageView(svgPath: ImageConstant.svgIconRightArrow),
      ),
    );
  }
}

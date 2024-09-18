import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/gp_util.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../res/strings.dart';
import '../controllers/payment_controller.dart';

class PromoCode extends GetView<PaymentController> {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.promoCode),
      ),
      body: Obx(
        () => controller.isPromoLoading.value
            ? const GpProgress()
            : ListView.builder(
                itemCount: controller.promoCodeModel.value.data!.length,
                itemBuilder: (context, index) {
                  final promoCode =
                      controller.promoCodeModel.value.data?[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.kh),
                        side: const BorderSide(color: ColorUtil.kGreyColor)),
                    tileColor: ColorUtil.kWhiteColor,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${promoCode?.promoCode}",
                          style: TextStyleUtil.k16Bold(),
                        ),
                        2.kwidthBox,
                        GestureDetector(
                          onTap: () => Get.dialog(
                            useSafeArea: true,
                            Center(
                              child: Container(
                                  padding: EdgeInsets.all(16.kh),
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    color: ColorUtil.kWhiteColor,
                                    borderRadius: BorderRadius.circular(8.kh),
                                  ),
                                  child: Text(
                                    "Description: ${promoCode?.description ?? "NA"}",
                                    style: TextStyleUtil.k14Regular(
                                        color: ColorUtil.kBlack03),
                                  )),
                            ),
                          ),
                          child: Icon(
                            Icons.info_outlined,
                            size: 18.kh,
                          ),
                        )
                      ],
                    ),
                    subtitle: Text(
                      "Expires: ${GpUtil.formatDate(DateTime.parse(promoCode?.expireDate ?? ""))}",
                      style:
                          TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                    ),
                    trailing: TextButton(
                        onPressed: promoCode?.status ?? false
                            ? () {
                                showMySnackbar(msg: Strings.alreadyUsedCoupon);
                              }
                            : () {
                                controller.applyDiscount(index);
                              },
                        child: Text(
                          Strings.apply,
                          style: TextStyleUtil.k14Semibold(
                              textDecoration: TextDecoration.underline,
                              color:
                                  Get.find<HomeController>().isPinkModeOn.value
                                      ? ColorUtil.kPrimaryPinkMode
                                      : ColorUtil.kSecondary01),
                        )),
                  ).paddingOnly(bottom: 8.kh, left: 16.kw, right: 16.kw);
                }).paddingOnly(top: 16.kw),
      ),
    );
  }
}

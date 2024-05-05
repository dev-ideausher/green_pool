import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../components/greenpool_appbar.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GreenPoolAppBar(
          title: Text("Wallet"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.kw, vertical: 24.kh),
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.kh),
                  gradient: const LinearGradient(
                      colors: [ColorUtil.kPrimary04, ColorUtil.kPrimary01])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Greenpool Cash",
                    style: TextStyleUtil.k18Heading600(),
                  ).paddingOnly(bottom: 16.kh),
                  Text(
                    "\$ 11.11",
                    style: TextStyleUtil.k32Heading700(
                        color: ColorUtil.kSecondary01),
                  ).paddingOnly(bottom: 20.kh),
                  Container(
                    width: 126.kw,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
                    decoration: BoxDecoration(
                        color: ColorUtil.kSecondary01,
                        borderRadius: BorderRadius.circular(80.kh)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: ColorUtil.kWhiteColor,
                          size: 16.kh,
                        ).paddingOnly(right: 3.kw),
                        Text(
                          "Gift card",
                          style: TextStyleUtil.k14Semibold(
                              color: ColorUtil.kWhiteColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: 32.kh, bottom: 24.kh),
            WalletTile(
              title: "Add money to wallet",
              path: ImageConstant.svgAddMoney,
              onTap: () {
                Get.toNamed(Routes.WALLET_ADD_MONEY);
              },
            ).paddingOnly(bottom: 8.kh),
            WalletTile(
              title: "Send Money to Bank Account",
              path: ImageConstant.svgSendMoney,
              onTap: () {
                Get.toNamed(Routes.WALLET_TO_BANK_ACC);
              },
            ).paddingOnly(bottom: 8.kh),
            WalletTile(
              title: "Transaction History",
              path: ImageConstant.svgTransactionHistory,
              onTap: () {
                Get.toNamed(Routes.TRANSACTION_HISTORY);
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 16.kw));
  }
}

class WalletTile extends StatelessWidget {
  final String title, path;
  final Function() onTap;
  const WalletTile({
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

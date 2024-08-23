import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../res/strings.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/transaction_history_controller.dart';

class TransactionHistoryView extends GetView<TransactionHistoryController> {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(Strings.transactionHistory),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : controller.transactions.isEmpty
                ? Center(
                    child: Center(
                    child: Text(
                      Strings.futureTransactionsWillBeVisibleHere,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ),
                  ))
                : ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.transactions[index];
                      return TransactionTile(
                              title: Get.find<HomeController>()
                                      .userInfo
                                      .value
                                      .data
                                      ?.fullName ??
                                  "",
                              path: Get.find<HomeController>()
                                      .userInfo
                                      .value
                                      .data
                                      ?.profilePic
                                      ?.url ??
                                  "",
                              onLongPress: () {
                                Get.dialog(
                                  useSafeArea: true,
                                  Center(
                                    child: Container(
                                        padding: EdgeInsets.all(16.kh),
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          color: ColorUtil.kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(8.kh),
                                        ),
                                        child: Text(
                                          "Id: #${transaction.Id}",
                                          style: TextStyleUtil.k14Regular(
                                              color: ColorUtil.kBlack03),
                                        )),
                                  ),
                                );
                              },
                              trailing: Text(
                                (transaction?.type ?? "") == "Credit"
                                    ? "+${Strings.dollar} ${transaction.amount}"
                                    : "-${Strings.dollar} ${transaction.amount}",
                                style: TextStyleUtil.k16Semibold(
                                    fontSize: 16.kh,
                                    color: (transaction?.type ?? "") == "Credit"
                                        ? ColorUtil.kGreenColor
                                        : ColorUtil.kError2),
                              ),
                              subtitle: "Id: #${transaction.Id}")
                          .paddingOnly(bottom: 8.kh, left: 16.kw, right: 16.kw);
                    }).paddingOnly(top: 8.kh),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title, path, subtitle;
  final Function() onLongPress;
  final Widget? trailing;

  const TransactionTile({
    super.key,
    required this.title,
    required this.path,
    required this.onLongPress,
    this.trailing,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78.kh,
      child: ListTile(
        tileColor: ColorUtil.kWhiteColor,
        onLongPress: onLongPress,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
        title: Text(
          title,
          style: TextStyleUtil.k14Semibold(),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
          overflow: TextOverflow.ellipsis,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.kh),
          child: CommonImageView(
            url: path,
            height: 40.kh,
            width: 40.kw,
          ),
        ),
        trailing: trailing ?? const SizedBox(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/origin_to_destination.dart';
import 'package:green_pool/app/data/transactions_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/utils/date_utils.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/route_widget.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/transaction_history_controller.dart';

class TransactionHistoryView extends GetView<TransactionHistoryController> {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_transactionHistory.tr),
        actions: [
          GestureDetector(
            onTap: () {
              controller.openFilterBottomsheet(context);
            },
            child: CommonImageView(svgPath: ImageConstant.svgIconFilter)
                .paddingOnly(right: 16.kw),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : controller.transactions.isEmpty
                ? Center(
                    child: Center(
                    child: Text(
                      LocaleKeys.app_futureTransactionsWillBeVisibleHere.tr,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ),
                  ))
                : ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.transactions[index];
                      return TransactionTile(
                        name: Get.find<GetStorageService>().getUserName,
                        path: Get.find<GetStorageService>().profilePicUrl,
                        dateTime: transaction.ride?.date ??
                            LocaleKeys.app_defaultDate.tr,
                        origin: transaction.ride?.pickupLocation?.name ?? "",
                        destination: transaction.ride?.dropLocation?.name ?? "",
                        subtitle: "Id: #${transaction.Id}",
                        onTap: () {
                          /*Get.dialog(
                            useSafeArea: true,
                            Center(
                              child: Container(
                                  padding: EdgeInsets.all(16.kh),
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                    color: ColorUtil.kWhiteColor,
                                    borderRadius: BorderRadius.circular(8.kh),
                                  ),
                                  child: _infoPopup(transaction)),
                            ),
                          );*/
                        },
                        trailing: Text(
                          (transaction?.type ?? "") == "Credit"
                              ? "+${LocaleKeys.app_dollar.tr} ${(transaction.amount ?? 0).toStringAsFixed(2)}"
                              : "-${LocaleKeys.app_dollar.tr} ${(transaction.amount ?? 0).toStringAsFixed(2)}",
                          style: TextStyleUtil.k16Semibold(
                              fontSize: 16.kh,
                              color: (transaction?.type ?? "") == "Credit"
                                  ? ColorUtil.kGreenColor
                                  : ColorUtil.kError2),
                        ),
                      ).paddingOnly(bottom: 8.kh, left: 16.kw, right: 16.kw);
                    }).paddingOnly(top: 8.kh),
      ),
    );
  }

  Column _infoPopup(TransactionsModelTransactions transaction) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Reason: ",
                style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack01),
              ),
              TextSpan(
                text: "${transaction.reason}",
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
              ),
            ],
          ),
        ),
        4.kheightBox,
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Id: ",
                style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack01),
              ),
              TextSpan(
                text: "${transaction.Id}",
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
              ),
            ],
          ),
        ),
        4.kheightBox,
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Origin: ",
                style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack01),
              ),
              TextSpan(
                text: "${transaction.ride?.pickupLocation?.name}",
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
              ),
            ],
          ),
        ),
        4.kheightBox,
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Destination: ",
                style: TextStyleUtil.k14Bold(color: ColorUtil.kBlack01),
              ),
              TextSpan(
                text: "${transaction.ride?.dropLocation?.name}",
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String name, path, subtitle, dateTime, origin, destination;
  final Function() onTap;
  final Widget? trailing;

  const TransactionTile({
    super.key,
    required this.name,
    required this.path,
    required this.onTap,
    this.trailing,
    required this.subtitle,
    required this.dateTime,
    required this.origin,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 78.kh,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.circular(8.kh),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              tileColor: ColorUtil.kWhiteColor,
              onTap: onTap,
              titleAlignment: ListTileTitleAlignment.top,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.kh)),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateTimeUtils.dayDateMonthYearTime(dateTime),
                      style: TextStyleUtil.k14Medium(
                          fontWeight: FontWeight.w500,
                          color: ColorUtil.kBlack03)),
                  Text(
                    name,
                    style: TextStyleUtil.k14Semibold(),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(80.kh),
                child: CommonImageView(
                  url: path,
                  height: 40.kh,
                  width: 40.kw,
                ),
              ),
              trailing: trailing ?? const SizedBox(),
            ),
            const GreenPoolDivider().paddingSymmetric(vertical: 8.kh),
            RouteWidget(
                origin: origin,
                destination: destination,
                stop1: "",
                stop2: "",
                needPickUp: true),
            const GreenPoolDivider().paddingSymmetric(vertical: 8.kh),
            // Text(
            //   subtitle,
            //   style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}

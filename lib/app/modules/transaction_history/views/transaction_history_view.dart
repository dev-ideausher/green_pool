import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';
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
                      LocaleKeys.app_looksLikeThereAreNoTransactions.tr,
                      style: TextStyleUtil.k24Heading600(),
                      textAlign: TextAlign.center,
                    ),
                  ))
                : ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.transactions[index];
                      final ride = transaction.rideDetails;
                      final isDebit =
                          (transaction.transactionType ?? "Debit") == "Debit";
                      return transaction.type != "wallet"
                          ? TransactionTile(
                              name: ride?.otherParty?.name ?? "",
                              path: ride?.otherParty?.profilePic?.url ?? "",
                              paidBy: ride?.otherParty?.role ?? "",
                              dateTime: transaction.date ??
                                  LocaleKeys.app_defaultDate.tr,
                              origin: ride?.origin?.name ?? "",
                              destination: ride?.destination?.name ?? "",
                              subtitle: "Id: #${transaction.transactionId}",
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    (transaction.amount ?? 0)
                                        .toStringAsFixed(2),
                                    style: TextStyleUtil.k16Semibold(
                                        fontSize: 16.kh),
                                  ),
                                  2.kwidthBox,
                                  Icon(
                                    !isDebit
                                        ? Icons.call_received
                                        : Icons.arrow_outward,
                                    color: !isDebit
                                        ? ColorUtil.kGreenColor
                                        : ColorUtil.kError2,
                                  )
                                ],
                              ),
                            ).paddingOnly(
                              bottom: 8.kh, left: 16.kw, right: 16.kw)
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.kw, vertical: 8.kh),
                              decoration: BoxDecoration(
                                color: ColorUtil.kWhiteColor,
                                borderRadius: BorderRadius.circular(8.kh),
                              ),
                              child: ListTile(
                                onTap: null,
                                tileColor: ColorUtil.kWhiteColor,
                                titleAlignment: ListTileTitleAlignment.top,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.kh)),
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        DateTimeUtils.dayDateMonthYearTime(
                                            transaction.date ??
                                                LocaleKeys.app_defaultDate.tr),
                                        style: TextStyleUtil.k14Medium(
                                            fontWeight: FontWeight.w500,
                                            color: ColorUtil.kBlack03)),
                                    Text(
                                      transaction.description ??
                                          LocaleKeys.app_loading.tr,
                                      style: TextStyleUtil.k14Semibold(),
                                    ),
                                  ],
                                ),
                                contentPadding: EdgeInsets.zero,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(80.kh),
                                  child: CommonImageView(
                                    url:
                                        ride?.otherParty?.profilePic?.url ?? "",
                                    height: 40.kh,
                                    width: 40.kw,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      !isDebit
                                          ? (transaction.amount ?? 0)
                                              .toStringAsFixed(2)
                                          : (transaction.amount ?? 0)
                                              .toStringAsFixed(2),
                                      style: TextStyleUtil.k16Semibold(
                                          fontSize: 16.kh),
                                    ),
                                    2.kwidthBox,
                                    Icon(
                                      !isDebit
                                          ? Icons.call_received
                                          : Icons.arrow_outward,
                                      color: !isDebit
                                          ? ColorUtil.kGreenColor
                                          : ColorUtil.kError2,
                                    )
                                  ],
                                ),
                              ),
                            ).paddingOnly(
                              bottom: 8.kh, left: 16.kw, right: 16.kw);
                    }).paddingOnly(top: 8.kh),
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String name, path, subtitle, dateTime, origin, destination, paidBy;
  final Widget? trailing;

  const TransactionTile({
    super.key,
    required this.name,
    required this.path,
    this.trailing,
    required this.subtitle,
    required this.dateTime,
    required this.origin,
    required this.destination,
    required this.paidBy,
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
            /* completed ride as rider/driver
              Container(
              padding: EdgeInsets.symmetric(horizontal: 12.kw, vertical: 2.kh),
              decoration: BoxDecoration(
                  color: isPinkModeOn
                      ? ColorUtil.kSecondaryPinkMode
                      : ColorUtil.kPrimary06,
                  borderRadius: BorderRadius.circular(16.kh)),
              child: Text(
                paidBy,
                style: TextStyleUtil.k12Semibold(
                  color: isPinkModeOn
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                ),
              ),
            ),*/
            ListTile(
              tileColor: ColorUtil.kWhiteColor,
              onTap: null,
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
            const GreenPoolDivider().paddingOnly(top: 8.kh),
            RouteWidget(
                origin: origin,
                destination: destination,
                stop1: "",
                stop2: "",
                needPickUp: true),
            const GreenPoolDivider().paddingOnly(bottom: 8.kh),
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

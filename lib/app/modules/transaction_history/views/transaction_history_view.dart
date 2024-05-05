import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/common_image_view.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/transaction_history_controller.dart';

class TransactionHistoryView extends GetView<TransactionHistoryController> {
  const TransactionHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GreenPoolAppBar(
        title: Text("Transaction History"),
      ),
      body: SizedBox(
        child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return TransactionTile(
                      title: "Jenny Wilson",
                      path: ImageConstant.pngUserSquare,
                      onTap: () {},
                      subtitle: "Booking Id: #529645488")
                  .paddingOnly(bottom: 8.kh);
            }),
      ).paddingOnly(top: 32.kh),
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title, path, subtitle;
  final Function() onTap;
  final Widget? trailing;
  const TransactionTile({
    super.key,
    required this.title,
    required this.path,
    required this.onTap,
    this.trailing,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78.kh,
      child: ListTile(
        tileColor: ColorUtil.kWhiteColor,
        onTap: onTap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
        title: Text(
          title,
          style: TextStyleUtil.k14Semibold(),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack04),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: Container(
          height: 40.kh,
          width: 40.kw,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtil.kBlack07,
              borderRadius: BorderRadius.circular(12.kh)),
          child: CommonImageView(
            imagePath: path,
          ),
        ),
        trailing: trailing ??
            Text(
              "\$ 50",
              style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
            ),
      ),
    );
  }
}

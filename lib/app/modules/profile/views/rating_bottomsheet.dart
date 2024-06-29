import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';

class RatingBottomSheet extends GetView<ProfileController> {
  const RatingBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.kh),
      height: 70.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.kh),
              topRight: Radius.circular(40.kh))),
      child: Column(
        children: [
          Text(
            'Enjoying Green Pool App ?',
            style: TextStyleUtil.k18Semibold(),
          ).paddingOnly(bottom: 8.kh),
          Image.asset(
            ImageConstant.gifRateUs,
            height: 200.kh,
            width: 200.kw,
          ),
          Text(
            'Support us by giving rate and your\nprecious review !\nIt will take few seconds only.',
            style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            textAlign: TextAlign.center,
          ).paddingOnly(bottom: 24.kh),
          RatingBar(
            allowHalfRating: false,
            glow: false,
            ratingWidget: RatingWidget(
              full: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              half: const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              empty: const Icon(
                Icons.star,
                color: ColorUtil.kGreyColor,
              ),
            ),
            onRatingUpdate: (double? value) {
              controller.rating.value = value ?? 4.5;
            },
          ).paddingOnly(bottom: 16.kh),
          GreenPoolTextField(
            hintText: "Feedback/suggestions",
            controller: controller.ratingTextController,
          ).paddingOnly(bottom: 16.kh),
          TextButton(
            onPressed: () {
              controller.submitFeedback();
            },
            child: Text(
              'Submit',
              style: TextStyleUtil.k16Bold(),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Maybe Later',
              style: TextStyleUtil.k16Bold(),
            ),
          ),
        ],
      ),
    );
  }
}

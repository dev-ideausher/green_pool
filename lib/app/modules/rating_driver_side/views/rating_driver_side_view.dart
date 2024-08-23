import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../res/strings.dart';
import '../controllers/rating_driver_side_controller.dart';

class RatingDriverSideView extends GetView<RatingDriverSideController> {
  const RatingDriverSideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(ImageConstant.svgRideCompleted)
                .paddingOnly(top: 40.kh, bottom: 24.kh),
            Text(
              Strings.rideCompleted,
              style: TextStyleUtil.k24Heading600(),
              textAlign: TextAlign.center,
            ).paddingOnly(bottom: 8.kh),
            Text(
              Strings.hopeYouHadGreatExperience,
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.kh),
                        topRight: Radius.circular(40.kh))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        Strings.rateRiders,
                        style: TextStyleUtil.k18Heading600(),
                      ).paddingOnly(top: 40.kh),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: controller
                              .myRidesModel
                              .value
                              .driverBookingDetails!
                              .riderBookingDetails!
                              .length,
                          itemBuilder: (context, index) {
                            final riderDetails = controller
                                .myRidesModel
                                .value
                                .driverBookingDetails!
                                .riderBookingDetails?[index]
                                .riderDetails;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(riderDetails?.fullName ?? ""),
                                    Container(
                                        height: 40.kh,
                                        width: 40.kw,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.kh),
                                          child: CommonImageView(
                                            url:
                                                riderDetails?.profilePic?.url ??
                                                    "",
                                          ),
                                        )),
                                  ],
                                ),
                                RatingBar(
                                  initialRating: controller.rating.value,
                                  allowHalfRating: false,
                                  itemSize: 28.kh,
                                  glow: false,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    half: Icon(
                                      Icons.star,
                                      color: Colors.amber.withOpacity(0.2),
                                    ),
                                    empty: const Icon(
                                      Icons.star,
                                      color: ColorUtil.kGreyColor,
                                    ),
                                  ),
                                  onRatingUpdate: (double? value) {
                                    controller.rating.value = value ?? 4;
                                    controller.debouncer(() => controller
                                        .rateUserAPI("${riderDetails?.Id}"));
                                  },
                                ),
                                const GreenPoolDivider()
                                    .paddingOnly(top: 16.kh, bottom: 16.kh),
                              ],
                            );
                          }),
                    ),
                    GreenPoolButton(
                      onPressed: () {
                        //?index in riders
                        // controller.rateUserAPI(
                        //     "${controller.myRidesModel.value.driverBookingDetails!.riders?[0]}");
                        Get.until((route) =>
                            Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                      },
                      label: Strings.continueText,
                    ).paddingOnly(top: 40.kh, bottom: 10.kh),
                    12.kheightBox,
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
              ),
            )
          ],
        ),
      ),
    );
  }
}

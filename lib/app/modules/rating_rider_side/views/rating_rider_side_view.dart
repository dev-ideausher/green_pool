import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../controllers/rating_rider_side_controller.dart';

class RatingRiderSideView extends GetView<RatingRiderSideController> {
  const RatingRiderSideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 450.kh,
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rate Driver",
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(top: 40.kh, bottom: 16.kh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "${controller.myRidesModel?.value.driverDetails?.fullName}"),
                  Image.asset(ImageConstant.pngUserSquare)
                ],
              ),
              SizedBox(
                height: 28.kh,
                child: RatingBar(
                  allowHalfRating: true,
                  glow: false,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: const Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    empty: const Icon(
                      Icons.star,
                      color: ColorUtil.kGreyColor,
                    ),
                  ),
                  onRatingUpdate: (double value) {},
                ),
              ),
              const GreenPoolDivider().paddingOnly(top: 16.kh, bottom: 24.kh),
              Text(
                "Rate your Carpool Companions",
                style: TextStyleUtil.k18Heading600(),
              ).paddingOnly(bottom: 16.kh),
              SizedBox(
                height: controller.numberOfRiders * 92.kh,
                child: ListView.builder(
                    itemCount: controller.numberOfRiders,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Esther Howard"),
                              Image.asset(ImageConstant.pngUserSquare)
                            ],
                          ),
                          SizedBox(
                            height: 28.kh,
                            child: RatingBar(
                              allowHalfRating: true,
                              glow: false,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: Icon(
                                  Icons.star,
                                  color: Colors.amber.withOpacity(0.5),
                                ),
                                empty: const Icon(
                                  Icons.star,
                                  color: ColorUtil.kGreyColor,
                                ),
                              ),
                              onRatingUpdate: (double value) {},
                            ),
                          ),
                          const GreenPoolDivider()
                              .paddingOnly(top: 16.kh, bottom: 16.kh),
                        ],
                      );
                    }),
              ),
              GreenPoolButton(
                onPressed: () {
                  Get.until(
                      (route) => Get.currentRoute == Routes.BOTTOM_NAVIGATION);
                },
                label: "Continue",
              ).paddingOnly(top: 40.kh, bottom: 10.kh),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(ImageConstant.svgRideCompleted)
                .paddingOnly(top: 40.kh, bottom: 24.kh),
            Text(
              "Ride Completed!",
              style: TextStyleUtil.k24Heading600(),
              textAlign: TextAlign.center,
            ).paddingOnly(bottom: 8.kh),
            Text(
              "Hope you had a great car pooling\nexperience!",
              style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/green_pool_divider.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../controllers/rating_driver_side_controller.dart';

class RatingDriverSideView extends GetView<RatingDriverSideController> {
  const RatingDriverSideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.kh),
                topRight: Radius.circular(40.kh))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Rate Riders",
                  style: TextStyleUtil.k18Heading600(),
                ).paddingOnly(top: 40.kh),
              ),
              SizedBox(
                height: controller.myRidesModel.value.postsInfo!.length * 92.kh,
                child: ListView.builder(
                    itemCount: controller.myRidesModel.value.postsInfo?.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${controller.myRidesModel.value.postsInfo?[index]?.riderPostsDetails?[0]?.ridersDetails?[0]?.fullName}"),
                              Container(
                                  height: 40.kh,
                                  width: 40.kw,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.kh),
                                    child: Image(
                                      image: NetworkImage(
                                          "${controller.myRidesModel.value.postsInfo?[index]?.riderPostsDetails?[0]?.ridersDetails?[0]?.profilePic?.url}"),
                                    ),
                                  )),
                            ],
                          ),
                          RatingBar(
                            allowHalfRating: true,
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
                              controller.rating = value;
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
                  //index in postsInfo
                  controller.rateUserAPI(
                      "${controller.myRidesModel.value.postsInfo?[0]?.riderPostsDetails?[0]?.ridersDetails?[0]?.Id}");
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

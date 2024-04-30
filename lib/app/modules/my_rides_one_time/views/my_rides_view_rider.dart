import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/my_rides_one_time/controllers/my_rides_one_time_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../components/green_pool_divider.dart';
import '../../../constants/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../services/text_style_util.dart';
import '../../profile/controllers/profile_controller.dart';

class RiderMyRidesView extends GetView<MyRidesOneTimeController> {
  final int? index;
  const RiderMyRidesView({super.key, this.index});
  @override
  Widget build(BuildContext context) {
    return SizedBox();

    // GestureDetector(
    //   onTap: controller.myRidesModelData[index]!.rideStatus == "Confirmed"
    //       ? () {
    //           Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
    //               arguments: controller.myRidesModelData[index]);
    //         }
    //       : () {
    //           Get.toNamed(Routes.RIDER_MY_RIDE_REQUEST,
    //               arguments: controller.myRidesModelData[index]?.Id);
    //         },
    //   child: Container(
    //     padding: EdgeInsets.all(16.kh),
    //     decoration: BoxDecoration(
    //       color: ColorUtil.kWhiteColor,
    //       borderRadius: BorderRadius.circular(8.kh),
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // ---------------- if rider and driver both have confirmed the ride ------------------- //
    //         controller.myRidesModelData[index]!.rideStatus == "Confirmed"
    //             ? Row(
    //                 children: [
    //                   //for profile pic and rating
    //                   Stack(
    //                     children: [
    //                       Container(
    //                         height: 64.kh,
    //                         width: 64.kw,
    //                         decoration: const BoxDecoration(
    //                           shape: BoxShape.circle,
    //                         ),
    //                         child: Image(
    //                           image: NetworkImage(
    //                               "${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.profilePic?.url}"),
    //                         ),
    //                       ).paddingOnly(bottom: 8.kh),
    //                       Positioned(
    //                         top: 52.kh,
    //                         left: 8.kw,
    //                         child: Container(
    //                           width: 48.kw,
    //                           height: 20.kh,
    //                           padding: EdgeInsets.symmetric(horizontal: 8.kw),
    //                           decoration: BoxDecoration(
    //                               color: Get.find<ProfileController>()
    //                                       .isSwitched
    //                                       .value
    //                                   ? ColorUtil.kPrimary3PinkMode
    //                                   : ColorUtil.kSecondary01,
    //                               borderRadius: BorderRadius.circular(16.kh)),
    //                           child: Row(
    //                             children: [
    //                               Icon(
    //                                 Icons.star,
    //                                 color: Get.find<ProfileController>()
    //                                         .isSwitched
    //                                         .value
    //                                     ? ColorUtil.kWhiteColor
    //                                     : ColorUtil.kYellowColor,
    //                                 size: 12.kh,
    //                               ).paddingOnly(right: 2.kw),
    //                               Text(
    //                                 '4.5',
    //                                 style: TextStyleUtil.k12Semibold(
    //                                     color: Get.find<ProfileController>()
    //                                             .isSwitched
    //                                             .value
    //                                         ? ColorUtil.kBlack02
    //                                         : ColorUtil.kWhiteColor),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ).paddingOnly(right: 16.kw, bottom: 16.kh),
    //                   //for name and date
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Text(
    //                               // 'Savannah Nguyen',
    //                               "${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.driverDetails?[0]?.fullName}",
    //                               style: TextStyleUtil.k16Bold(),
    //                             ),
    //                             Text.rich(
    //                               TextSpan(
    //                                 children: [
    //                                   TextSpan(
    //                                     text: 'Fare: ',
    //                                     style: TextStyleUtil.k14Semibold(
    //                                         color: ColorUtil.kSecondary01),
    //                                   ),
    //                                   TextSpan(
    //                                     text:
    //                                         '\$ ${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.origin?.originDestinationFair}',
    //                                     style: TextStyleUtil.k16Semibold(
    //                                         fontSize: 16.kh,
    //                                         color: ColorUtil.kSecondary01),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ).paddingOnly(bottom: 8.kh),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 SvgPicture.asset(
    //                                   ImageConstant.svgIconCalendarTime,
    //                                   colorFilter: ColorFilter.mode(
    //                                       Get.find<ProfileController>()
    //                                               .isSwitched
    //                                               .value
    //                                           ? ColorUtil.kPrimary3PinkMode
    //                                           : ColorUtil.kSecondary01,
    //                                       BlendMode.srcIn),
    //                                 ).paddingOnly(right: 4.kw),
    //                                 Text(
    //                                   // '07 Nov 2023, 3:00pm',
    //                                   '${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData[index]?.time ?? " "}',
    //                                   style: TextStyleUtil.k12Regular(
    //                                       color: ColorUtil.kBlack03),
    //                                 ),
    //                               ],
    //                             ),
    //                             Row(
    //                               children: [
    //                                 Icon(
    //                                   Icons.time_to_leave,
    //                                   size: 18.kh,
    //                                   color: Get.find<ProfileController>()
    //                                           .isSwitched
    //                                           .value
    //                                       ? ColorUtil.kPrimary3PinkMode
    //                                       : ColorUtil.kSecondary01,
    //                                 ).paddingOnly(right: 8.kw),
    //                                 Text(
    //                                   '${controller.myRidesModelData[index].confirmDriverDetails?[0]?.driverPostsDetails?[0]?.seatAvailable} seats',
    //                                   style: TextStyleUtil.k14Regular(
    //                                       color: ColorUtil.kBlack03),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             : const SizedBox(),

    //         // time view if not confirmed by rider
    //         controller.myRidesModelData[index]!.rideStatus != "Confirmed"
    //             ? Row(
    //                 children: [
    //                   // ----------- if rider has not seleted any date while doing "Find a Ride" -------------//
    //                   controller.myRidesModelData[index]?.date == null
    //                       ? const SizedBox()
    //                       : SvgPicture.asset(
    //                           ImageConstant.svgIconCalendarTime,
    //                           colorFilter: ColorFilter.mode(
    //                               Get.find<HomeController>().isSwitched.value
    //                                   ? ColorUtil.kPrimary3PinkMode
    //                                   : ColorUtil.kSecondary01,
    //                               BlendMode.srcIn),
    //                         ).paddingOnly(right: 4.kw),
    //                   controller.myRidesModelData[index]?.date == null
    //                       ? const SizedBox()
    //                       : Text(
    //                           // '07 Nov 2023, 3:00pm',
    //                           '${controller.myRidesModelData[index]?.date.toString().split("T")[0] ?? " "}  ${controller.myRidesModelData[index]?.time ?? " "}',
    //                           style: TextStyleUtil.k16Bold(),
    //                         ),
    //                 ],
    //               ).paddingOnly(bottom: 16.kh)
    //             : const SizedBox(),
    //         //middle divider
    //         controller.myRidesModelData[index]?.date == null
    //             ? const SizedBox()
    //             : const GreenPoolDivider().paddingOnly(bottom: 16.kh),
    //         OriginToDestination(
    //                 origin:
    //                     "${controller.myRidesModelData[index]?.origin?.name}",
    //                 destination:
    //                     "${controller.myRidesModelData[index]?.destination?.name}")
    //             .paddingOnly(bottom: 8.kh),

    //         // view details button and cancel ride button
    //         controller.myRidesModelData[index]!.rideStatus != "Confirmed"
    //             ? const SizedBox()
    //             : Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   GreenPoolButton(
    //                     height: 40.kh,
    //                     width: 144.kw,
    //                     padding: EdgeInsets.all(0.kh),
    //                     onPressed: () {
    //                       Get.toNamed(Routes.RIDER_CONFIRMED_RIDE_DETAILS,
    //                           arguments: controller.myRidesModelData[index]);
    //                     },
    //                     label: 'View Details',
    //                     fontSize: 14.kh,
    //                     borderColor:
    //                         Get.find<HomeController>().isSwitched.value
    //                             ? ColorUtil.kPrimary3PinkMode
    //                             : ColorUtil.kSecondary01,
    //                     labelColor:
    //                         Get.find<HomeController>().isSwitched.value
    //                             ? ColorUtil.kPrimary3PinkMode
    //                             : ColorUtil.kSecondary01,
    //                   ),
    //                   GreenPoolButton(
    //                     height: 40.kh,
    //                     width: 144.kw,
    //                     padding: EdgeInsets.all(0.kh),
    //                     onPressed: () {
    //                       // controller.cancelRideAPI(
    //                       //     controller
    //                       //             .myRidesModelData[
    //                       //         index]!);
    //                     },
    //                     isBorder: true,
    //                     label: 'Cancel Ride',
    //                     fontSize: 14.kh,
    //                     borderColor:
    //                         Get.find<HomeController>().isSwitched.value
    //                             ? ColorUtil.kPrimary3PinkMode
    //                             : ColorUtil.kSecondary01,
    //                     labelColor:
    //                         Get.find<HomeController>().isSwitched.value
    //                             ? ColorUtil.kPrimary3PinkMode
    //                             : ColorUtil.kSecondary01,
    //                   ),
    //                 ],
    //               ),
    //       ],
    //     ).paddingOnly(bottom: 16.kh),
    //   ).paddingOnly(bottom: 16.kh),
    // );
  }
}
